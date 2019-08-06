class SessionsController < ApplicationController

before_action :check_status,only:[:new,:create,:login_method]
before_action :set_current_user,only:[:dashboard,:destroy]
  

def new
  #binding.pry
  @method = params[:method]
end

def login_method
end


def create
  #binding.pry
  if params[:session][:user_name]
  @admin = Admin.find_by(user_name: params[:session][:user_name])
  elsif params[:session][:mobile]
  @admin = Admin.find_by(mobile_number: params[:session][:mobile])
  elsif params[:session][:email]
  @admin = Admin.find_by(email: params[:session][:email])
  
  end
  if @admin
    if @admin.pverified
    
      if @admin && @admin.authenticate(params[:session][:password])
    	 session[:unique_id]=Admin.find_by(user_name: params[:session][:user_name]).id if params[:session][:user_name]
        session[:unique_id]=Admin.find_by(mobile_number: params[:session][:mobile]).id if params[:session][:mobile]
         session[:unique_id]=Admin.find_by(email: params[:session][:email]).id if params[:session][:email]
    	 @admin.otp = [1,2,3,4,5,6,7,8,9,0].shuffle.take(4).join
     	 @admin.save
    	 AdminMailer.send_otp_email(@admin).deliver_now
    	 redirect_to sessions_otp_verification_path
    	 
      else
        flash.now[:alert] = "Email or password is invalid"
        render "new"
      end
    else
    	session[:mobile] = @admin.id
    	redirect_to new_phone_verification_path,notice: "First verify your mobile_number!"
    end	
    else
  redirect_to sessions_login_method_path,notice: "No such user present!"
   end   
end


  def destroy
    
    session[:admin_id]=nil
    redirect_to sessions_login_method_path, notice: "Logged out!"
  end

  def dashboard
  	#binding.pry
  	@admin=current_user
  	
  		redirect_to sessions_login_method_path if current_user==nil

  end

  def otp_verification
  	return redirect_to sessions_login_method_path unless session[:unique_id].present?
  	if (current_user.present?)
       redirect_to dashboard_path
    else
    	
    end    
  end

    def otp_verify
    	#binding.pry
  	   if session[:unique_id]
          @admin=Admin.find_by(id: session[:unique_id])  
  	      if @admin.otp==params[:session][:otp].to_i
    	    log_in(@admin)
    	    session[:unique_id] = nil
    	    redirect_to dashboard_path,notice: "Logged in! as:"
          else
            flash.now[:alert] = "Sorry! otp didn't match"
            render "otp_verification"
          end
        else
          redirect_to sessions_login_method_path
        end        	
   end

  #  def email_verify
  #   return redirect_to login_path unless session[:unique_id].present?
  # 	if (current_user.present?)
  #      redirect_to dashboard_path
  #   else
     
  #  end
  # end

  #  def email_verification
  #  	@admin=Admin.find_by(id: session[:email])
  #   	if @admin.otp == params[:eotp].to_i
  #   		@admin.update(everified: true,otp: nil)
  #   		session.delete(:email)
  #   		redirect_to login_path,notice: "Your email is successfully verified!"
  #   	else
  #   		flash.now[:alert] = "Sorry! otp didn't match"
  #           render "email_verify"
    		
  #       end
  #  end

   def phone_verify
   end

   

  



   def check_status
       redirect_to dashboard_path if current_user.present?
   end

   def set_current_user
       current_user = session[:admin_id] if current_user.present?
   end

end
