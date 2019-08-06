class AdminMailer < ApplicationMailer

	default :from => 'ror-trainee@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(admin)
    @admin = admin
    mail( :to => @admin.email,:subject => 'Thanks for signing up ,you are welcome' )
  end

  def send_otp_email(admin)
  	@admin=admin
  	mail( :to => @admin.email,:subject => 'otp' )

  end

  def forgot_password(admin)
  @admin = admin
  @greeting = "Hi"
  
  mail( to: @admin.email, :subject => 'Reset password instructions')
  end

end
