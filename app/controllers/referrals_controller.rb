class ReferralsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def create
    @server = Server.find(params[:server_id])
    @referral = Referral.new(user: current_user, server: @server, expires_at: 1.week.from_now)
    if @referral.save
      referral_link = referral_url(@referral.token)
      redirect_to servers_path, notice: t("referrals.notice.created", url: referral_link)
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
      render :show
    else
      redirect_to root_path, alert: t("referrals.alert.invalid")
    end
  end
end