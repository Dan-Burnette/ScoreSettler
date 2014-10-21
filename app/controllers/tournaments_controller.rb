class TournamentsController < ApplicationController
  before_action :authenticate_user!

  #Show all tournaments on the user
  def index
  end


 #Create tournament, randomize players, make its matches, redirect to it's view if successful
  def create

    #Setting up the players 
    players = params[:players]
    player_count = players.size

    if (player_count < 4)
      byes = 4 - player_count
      t_size = 4
    elsif (player_count < 8)
      byes = 4 - player_count
      t_size = 8
    elsif (player_count < 16)
      byes = 4 - player_count
      t_size = 16
    else
      t_size = 'too big'
    end

    byes.times { players.push("bye") }
    players.shuffle!

    #Setting up the matches
    

    #Actual tournament creation
    if (t_size != 'too big')
      tournament = Tournament.new(tournament_params)
      if (tournament.save)
        redirect_to tournament_path(tournament.id, :players => players)
      else
        #error did not save !
      end
    else
      #error t_size too big
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
