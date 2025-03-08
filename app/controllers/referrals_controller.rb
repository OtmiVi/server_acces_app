class ReferralsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def create
    @server = Server.find(params[:server_id])
    @referral = Referral.new(server: @server, expires_at: 1.week.from_now)
    if @referral.save
      referral_link = referral_url(@referral.token)
      respond_to do |format|
        format.html { redirect_to servers_path, notice: t("referrals.notice.created", url: referral_link) }
        format.turbo_stream do
          flash.now[:notice] = t("referrals.notice.created", url: referral_link)
          render turbo_stream: [
            turbo_stream.update("flash", partial: "layouts/flash"),
            turbo_stream.replace("servers_list", partial: "servers/servers_list", locals: { servers: current_user.servers })
          ]
        end
      end
    else
      redirect_to servers_path, alert: t("referrals.alert.error")
    end
  end

  def show
    cache_key = "referral/#{params[:token]}"
    @referral = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      Referral.find_by(token: params[:token])
    end
    if @referral && @referral.expires_at > Time.now
      @server = @referral.server
      if user_signed_in?
        unless current_user.servers.include?(@server)
          current_user.servers << @server
          Rails.cache.delete_matched("servers/#{current_user.id}/*")
        end
        redirect_to servers_path, notice: t("referrals.notice.added", server: @server.name)
      else
        redirect_to new_user_session_path, alert: t("referrals.alert.login_required")
      end
    else
      redirect_to root_path, alert: t("referrals.alert.invalid")
    end
  end
end
