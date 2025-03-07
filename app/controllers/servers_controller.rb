class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: [:new, :create]

  def index
    cache_key = "servers/#{current_user.id}/#{current_user.role}/#{Server.maximum(:updated_at)}"
    @servers = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      current_user.admin? ? Server.all : current_user.servers
    end
  end

  def new
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    @server.user = current_user
    if @server.save
      Rails.cache.delete_matched("servers/*")
      redirect_to servers_path, notice: t("servers.notice.created")
    else
      render :new
    end
  end

  private

  def server_params
    params.require(:server).permit(:name, :username, :host, :password)
  end

  def ensure_admin
    redirect_to servers_path, alert: t("servers.alert.access_denied") unless current_user.admin?
  end
end