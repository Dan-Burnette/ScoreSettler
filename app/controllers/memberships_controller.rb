class MembershipsController < ApplicationController
  before_action :authenticate_user!

  #Called when an admin sends an invite
  def create
    user_id = User.find_by(username: params[:username]).id
    group_id = params[:group_id].to_i
    status = params[:status]

    pending_membership = Membership.new(group_id: group_id, user_id: user_id, status: status)
    if (pending_membership.save)
      redirect_to :back
    else
      #membership was a duplicate invite, nothing will happen
      redirect_to :back
    end
  end

  #Called when a user accepts an invite and the status of the membership
  #must change to "active" 
  def update
    status = params[:status]
    membership = Membership.find(params[:id])
    membership.update(status: status)
    redirect_to :back, status: 303
  end

end
