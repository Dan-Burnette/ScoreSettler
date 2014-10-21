class UsersController < ApplicationController
  before_action :authenticate_user!

  # def create
    #Handled upon registration by devise
  # end

  #Main User Page, shows all their groups
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


end
