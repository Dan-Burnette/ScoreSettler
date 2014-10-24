class UsersController < ApplicationController
  before_action :authenticate_user!

  # def create
    #Handled upon registration by devise
  # end

  #Main User Page, shows all their groups
  def show
    @user = current_user
    @user_groups = @user.groups
  end

end
