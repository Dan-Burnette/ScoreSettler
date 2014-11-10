class MembershipsController < ApplicationController
  before_action :authenticate_user!

  #Called when an admin sends an invite
  def create
    user_id = User.find_by(username: params[:username]).id
    group_id = params[:group_id].to_i
    status = params[:status]
    #prevent duplicate memberships
    isExisting = Membership.where("group_id = ? AND user_id = ?", group_id, user_id)[0]
    if (isExisting == nil)
      pending_membership = Membership.new(group_id: group_id, user_id: user_id, status: status)
      if (pending_membership.save)
        redirect_to :back, status: 303
      else
        #need to display error
        redirect_to :back, status: 303
      end
    else
      redirect_to :back, status: 303
    end
  end

  #Called when a user accepts an invite and the status of the membership
  #must change to "active" 
  def update
    user_id = params[:user_id]
    group_id = params[:group_id]
    status = params[:status]
    membership = Membership.find(params[:id])
    membership.update(status: status)
    redirect_to :back, status: 303
  end

  def membership_params
    params.require(:membership).permit(:user_id, :group_id, :status)
  end

end
