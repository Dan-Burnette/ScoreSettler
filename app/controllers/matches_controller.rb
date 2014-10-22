class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    match = Match.new(match_params)
    if (match.save)
      #cool it worked
    else
      #there is an error
    end
  end

  #Recieves AJAX request from playTournament.js when tournament changes
  def update
    tournament_id = params[:tournament_id].to_i
    player_1 = User.find_by(username: params[:player1])
    #will be nil if the player was a bye
    if (player_1 != nil)
      player_1 = player_1.id
    end
    player_2 = User.find_by(username: params[:player2])
    if (player_2 != nil)
      player_2 = player_2.id
    end

    winner_id = User.find_by(username: params[:winner]).id

    match = Match.find(params[:match].to_i)
    match.update(winner_id: winner_id, player_1: player_1, player_2: player_2, tournament_id: tournament_id)
    
    redirect_to :back
  end

  #Never need to show an individual match
  # def show
  # end

  def match_params
    params.require(:match).permit(:player_1, :player_2, :tournament_id, :winner_id)
  end

end
