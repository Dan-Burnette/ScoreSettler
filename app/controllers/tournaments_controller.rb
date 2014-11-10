class TournamentsController < ApplicationController
  before_action :authenticate_user!

  #Create tournament and necessary setup
  def create
    #Setting up the players 
    setup = SetupPlayers.run(params[:players])
    t_size = setup[:t_size]
    player_names = setup[:player_names]
  
    #Tournament creation
    if (t_size != 'too big')
      tournament = Tournament.new(tournament_params)
      tournament.size = t_size
      if (tournament.save)
        #Match setup for the tournament
        SetupMatches.run(tournament, t_size, player_names)
        redirect_to tournament_path(tournament.id)
      end
    else
      #error tournament size is too big
      flash[:alert] = "You chose a size that is currently unsupported. Please choose less participants."
      redirect_to group_path(params[:tournament][:group_id])
    end

  end

  #Called when user clicks on an active tournament
  def show
    @tournament = Tournament.find(params[:id])
    @matches = @tournament.matches.sort
    #Retrieve the players in the order that they appear on the view
    @all_player_spots = GetPlayers.run(@tournament, @matches)

    case @tournament.size
    when 4
      if (@tournament.double_elim)
        render 'show_four_person_double_elim_tournament'
      else
        render 'show_four_person_tournament'
     end
    when 8
      if (@tournament.double_elim)
        render 'show_eight_person_double_elim_tournament'
      else
        render 'show_eight_person_tournament'
      end
    end
  end

  #Updating the tournament champion when the tournament is completed
  def update
    tournament = Tournament.find(params[:id])
    champion_id = User.find_by(username: params[:winner]).id
    tournament.update(champion_id: champion_id)

    # If the last match winner id is nil, it was a double elim match that never had to be played. 
    # May as well delete it
    if (tournament.matches.last.winner_id == nil)
      Match.destroy(tournament.matches.last.id)
    end
  end

  def tournament_params
    params.require(:tournament).permit(:game_type, :group_id, :name, :champion_id, :size, :double_elim)
  end

end
