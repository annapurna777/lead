module SessionsHelper

def log_in(admin)
    session[:admin_id] = admin.id
end


   def current_user
     if session[:admin_id]
       @current_user ||= Admin.find_by(id: session[:admin_id])
     end
   end

   def logged_in?
    !current_user.nil?
   end


   def log_out
    session[:admin_id]=nil
    @current_user = nil
   end


end
