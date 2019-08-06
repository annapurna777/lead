class LeadersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :check_status,only: [:show,:clients,:make_client]
  def new
  end

  def index
    #binding.pry
  	@leaders=Leader.all
  end

  def create
  	#binding.pry
   @leader = Leader.new(leader_params)
   @leader.admin_id = current_user.id if current_user.present?
   if @leader.save
   	redirect_to leaders_path,notice: "Lead created"
   else
   	render 'new'
   end

  end

  def show
    @leader=Leader.find_by(id: params[:format])
  end

  def clients
   #binding.pry
   @leader=   Admin.find_by(id: current_user.id)
    @clients=Leader.where(made_by: @leader.id)
  end

  def make_client
   #binding.pry
    @leader=Leader.find_by(id: params[:format])
    @leader.made_by = current_user.id
    @leader.made_at =  TimeDifference.between(Time.now, @leader.created_at.to_datetime).in_each_component

    @leader.save
  end

   def check_status
       redirect_to sessions_login_method_path if !(current_user.present?)
   end


  private
  def leader_params
  	  	params.require(:leader).permit(:name,:docf,:docb,:account_number,:lead_type)
  end

end
