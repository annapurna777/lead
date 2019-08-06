class PasswordsController < ApplicationController


	def new 
	end


 def forgot
 #	binding.pry
    redirect_to dashboard_path if current_user.present?
    if params[:email].blank? # check if email is present
      redirect_to passwords_new_path,notice: 'Please enter your email'
    end

    @admin = Admin.find_by(email: params[:email]) # if present find user by email

    if @admin.present?
      @admin.generate_password_token! #generate pass token
      AdminMailer.forgot_password(@admin).deliver_now
      redirect_to sessions_login_method_path,notice: "password reset instructions has been sent to your email!"
    else
     return redirect_to passwords_new_path,notice: 'This email is not registered'
    end
 end

  def new_password
    #binding.pry

    if @admin=Admin.find_by(reset_password_token: params[:token])
    else  
    redirect_to login_path,notice: "Your token has expired" if (@admin.reset_password_sent_at+1.hour<Time.now)&&(@user.reset_password_token!=nil)
    end
  end

  def reset
    #binding.pry
    
    @admin = Admin.find_by(reset_password_token: params[:token])
    
    
    if @admin.present? && @admin.password_token_valid?
      if @admin.reset_password!(params[:admin][:password])
         redirect_to sessions_login_method_path,notice: "Your password is updated successfully"
      else
          return redirect_to sessions_login_method_path,notice: "Some error occured!"
      end
    else
        return redirect_to sessions_login_method_path,notice: "Token is not valid"
    end
  end

end
