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
    
    # Fill the next match with the victor of the other match into p1 or p2 
    if (params[:next_match] && params[:next_match_player])
      next_match = Match.find(params[:next_match].to_i)
      next_match_player = params[:next_match_player]
    end

  
    if (next_match_player == 'player1')
      next_match.update(player_1: winner_id)
    elsif (next_match_player == 'player2')
      next_match.update(player_2: winner_id)
    end

    redirect_to tournament_path(tournament_id), status: 303
  end



  def match_params
    params.require(:match).permit(:player_1, :player_2, :tournament_id, :winner_id)
  end

end
