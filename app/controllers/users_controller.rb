class UsersController < ApplicationController
  before_action :authenticate_user!

  # def create
    #Handled upon registration by devise
  # end

  #Show all that user's groups
  def show
    @user = current_user
    user_memberships = Membership.where("user_id = ?", @user.id)
    @user_groups = []
    user_memberships.each do |m|
      group = Group.find(m.group_id)
      puts group.name
      @user_groups.push(group)
    end 
    
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end

end
