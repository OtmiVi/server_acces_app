class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: [:new, :create]

  def index
    @servers = current_user.servers
  end

  def new
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      current_user.servers << @server
      Rails.cache.delete_matched("servers/*")
      redirect_to servers_path, notice: t("servers.notice.created")
    else
      render :new, status: :unprocessable_entity
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