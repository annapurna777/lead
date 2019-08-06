class NomineesController < ApplicationController
	before_action :check_status
	def create
    @leader = Leader.find(params[:leader_id])
    @nominee = @leader.nominees.create(nominee_params)
    redirect_to leaders_show_path(@leader)
  end


   def check_status
       redirect_to sessions_login__method_path if !(current_user.present?)
   end

 
  private
    def nominee_params
      params.require(:nominee).permit(:name, :age)
    end
end
