class MembershipsController < ApplicationController
  before_action :authenticate_user!

  #called on invite
  def create
    user_id = User.find_by(username: params[:username]).id
    group_id = params[:group_id].to_i
    status = params[:status]
    pending_membership = Membership.create(group_id: group_id, user_id: user_id, status: status)
    if (pending_membership.save)
      redirect_to :back
    else
      #need to display error
      redirect_to :back
    end
  end

  def update
    user_id = params[:user_id]
    group_id = params[:group_id]
    status = params[:status]
    membership = Membership.find(params[:id])
    membership.update(status: status)
    redirect_to :back
  end

  #Kick a user out a group or remove himself from a group
  def destroy
  end


  def membership_params
    params.require(:membership).permit(:user_id, :group_id, :status)
  end


#---Not used--------------------------------------------

  #Show a user all his memberships on his user show page
  # def index
  # end

  #no need to ever show a single membership
  # def show
  # end
end
