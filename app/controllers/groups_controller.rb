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
    @group = Group.find(params[:id])
    @group_members = @group.users

    # Tournament getting logic
    tournaments = @group.tournaments
    @complete_tournaments = []
    @champs = []
    @incomplete_tournaments = []
    tournaments.each do |t|
      if (t.champion_id == nil)
        @incomplete_tournaments.push(t)
      else
        @complete_tournaments.push(t)
        champ = User.find(t.champion_id)
        @champs.push(champ)
      end
    end
  end

  # Destroy a group
  # def destroy
  # end

  def group_params
    params.require(:group).permit(:name)
  end


end
