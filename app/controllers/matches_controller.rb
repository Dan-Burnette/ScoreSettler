class MatchesController < ApplicationController
  before_action :authenticate_user!

  #Recieves AJAX request from playTournament.js when tournament changes
  def update
    UpdateMatch.run(params)
    redirect_to tournament_path(tournament_id), status: 303
  end

end
