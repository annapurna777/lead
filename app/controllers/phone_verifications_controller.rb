class PhoneVerificationsController < ApplicationController
	before_action :check_status
  def new
  	@user=Admin.find_by(id: session[:mobile])
  end

  def create
  	#binding.pry
  	@user=Admin.find_by(id: session[:mobile])
    session[:mobile_number] = params[:mobile_number]
    session[:country_code] = params[:country_code]
    @response = Authy::PhoneVerification.start(
      via: params[:method],
      country_code: params[:country_code],
      phone_number: params[:mobile_number]
    )
    if @response.ok?
      redirect_to challenge_phone_verifications_path
    else
      render "verify"
    end
  end

   def verify
    @response = Authy::PhoneVerification.check(
      verification_code: params[:code],
      country_code: session[:country_code],
      phone_number: session[:mobile_number]
    )
    if @response.ok?
      session[:mobile_number] = nil
      session[:country_code] = nil
      @user=Admin.find_by(id: session[:mobile])
      @user.update(pverified: true)
      session[:mobile]=nil
      redirect_to sessions_login_method_path,notice: "Your phone number is successfully verified!"
    else
      render :challenge
    end
  end

  def challenge
  end

   def check_status
       redirect_to dashboard_path if current_user.present?
   end

end
