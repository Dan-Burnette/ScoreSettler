class UsersController < ApplicationController
  before_action :authenticate_user!

  # def create
    #Handled upon registration by devise
  # end

  #Main User Page, shows all their groups
  def show
    @user = current_user
    @user_groups = @user.groups


    @active_groups = []
    @pending_groups = []
    @pending_memberships = []
    @user.memberships.each do |m|
      if (m.status == "active")
        group = Group.find(m.group_id)
        @active_groups.push(group)
      elsif (m.status == "pending")
        group = Group.find(m.group_id)
        @pending_groups.push(group)
        @pending_memberships.push(m)
      end
    end
  end

end
