class AdminsController < ApplicationController
before_action :check_status,only:[:signup,:create]
   def signup
   end


  def create
    #binding.pry 
   
    @admin = Admin.new(admin_params)
    @admin.country_code = params[:country_code].to_i
     #if @admin.pverified?
    size = Admin.where(first_name: params[:admin][:first_name]).size
    @admin.otp = [1,2,3,4,5,6,7,8,9,0].shuffle.take(4).join
    @admin.user_name= params[:admin][:first_name]+size.to_s
    if @admin.save
     
      
      AdminMailer.send_signup_email(@admin).deliver_now
      if @admin.mobile_number.present?
        session[:mobile]=@admin.id
        redirect_to new_phone_verification_path(@admin)
      else
      redirect_to(login_path, :notice => 'Admin created')
      end
    else
     
      redirect_to admins_signup_path
    end
  #else
    #redirect_to admins_signup_path,notice: "Verify your mobile number first!"
  #end
  end

  


  def check_status
    
      redirect_to dashboard_path if current_user.present?
    
   
   end


  private
  def admin_params
  	params.require(:admin).permit(:first_name,:last_name,:email,:password,:mobile_number)
  end

end
