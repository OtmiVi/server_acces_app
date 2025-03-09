class ServersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_server, only: [ :edit, :update, :destroy ]

  def index
    cache_key = "servers/#{current_user.id}/#{Server.maximum(:updated_at)}"
    @servers = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      current_user.servers
    end
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

  def edit
  end

  def update
    if @server.update(server_params)
      Rails.cache.delete_matched("servers/*")
      redirect_to servers_path, notice: t("servers.notice.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @server.destroy
    Rails.cache.delete_matched("servers/*")
    redirect_to servers_path, notice: t("servers.notice.destroyed")
  end

  private

  def server_params
    params.require(:server).permit(:name, :username, :host, :password)
  end

  def ensure_admin
    redirect_to servers_path, alert: t("servers.alert.access_denied") unless current_user.admin?
  end

  def set_server
    @server = Server.find(params[:id])
    pp @server
  end
end
