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

  #for adding the winner to a match once complete
  def update
  end

  #Never need to show an individual match
  # def show
  # end

  def match_params
    params.require(:match).permit(:player_1, :player_2, :tournament_id, :winner_id)
  end

end
