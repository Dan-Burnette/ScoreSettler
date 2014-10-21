class TournamentsController < ApplicationController
  before_action :authenticate_user!

  #Show all tournaments on the user
  def index
  end

  def create
    tournament = Tournament.new(tournament_params)
    if (tournament.save)
      #Show the tournament!
      redirect_to tournament_path(tournament.id, :players => params[:players])
    else
      #error did not save !
    end
  end


  #Only to be used on in progress tournaments 
  def show
  end


  #To be used upon deletion of a group, destroy all tournaments associated with it
  def destroy

  end


  def tournament_params
    params.require(:tournament).permit(:game_type, :group_id, :name)
  end

end
