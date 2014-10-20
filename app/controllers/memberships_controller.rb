class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    membership = Membership.new(membership_params)
    if (membership.save)
      redirect_to user_path
    else
      #display error
    end
  end

  #Kick a user out a group or remove himself from a group
  def destroy
  end

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end


#---Not used--------------------------------------------

  #Show a user all his memberships on his user show page
  # def index
  # end

  #no need to ever show a single membership
  # def show
  # end
end
