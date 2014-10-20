class GroupsController < ApplicationController
  before_action :authenticate_user!

  #page for finding your friend's groups to apply for a membership 
  def index
  
  end


  #for creating a new group
  def create
    
  end

  #For showing a specific group page.
  #Should display a list of tournaments which can be clicked
  #Then the tournament shows all its matches
  def show

  end

  # Destroy a group
  # def destroy
  # end

  def group_params
    params.require(:group).permit(:name)
  end


end
