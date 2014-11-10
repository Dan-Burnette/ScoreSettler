class TournamentsController < ApplicationController
  before_action :authenticate_user!

 #Create tournament and necessary setups
  def create
    #Setting up the players 
    setup = SetupPlayers.run(params[:players])
    t_size = setup[:t_size]
    player_names = setup[:player_names]
  
    #Actual tournament creation
    if (t_size != 'too big')
      tournament = Tournament.new(tournament_params)
      tournament.size = t_size
      if (tournament.save)
        redirect_to tournament_path(tournament.id)
        #Match setup for the tournament
        SetupMatches.run(tournament, t_size, player_names)
      end
    else
      puts "IN THE ELSE----------------------"
      #error t_size too big
      flash[:alert] = "You chose a size that is currently unsupported. Please choose a smaller size."
      redirect_to group_path(params[:tournament][:group_id])
    end

  end

  def show
    @tournament = Tournament.find(params[:id])
    @matches = @tournament.matches.sort

    #Send in the names in order of where they should be
    #so that they can be populated in 
    #the view if tournament is in progress
    @all_player_spots = [];
    if (!@tournament.double_elim)
      for i in 0...@tournament.size - 1 
        p1 = User.find_by(id: (@matches[i].player_1.to_i))
        p2 = User.find_by(id: (@matches[i].player_2.to_i))
        if p1 != nil
          @all_player_spots.push(p1.username)
        else
          @all_player_spots.push(nil)
        end
        if p2 != nil
          @all_player_spots.push(p2.username)
        else
          @all_player_spots.push(nil)
        end
      end
    elsif (@tournament.double_elim)
      for i in 0...(2*@tournament.size - 1) 
        p1 = User.find_by(id: (@matches[i].player_1.to_i))
        p2 = User.find_by(id: (@matches[i].player_2.to_i))
        if p1 != nil
          @all_player_spots.push(p1.username)
        else
          @all_player_spots.push(nil)
        end
        if p2 != nil
          @all_player_spots.push(p2.username)
        else
          @all_player_spots.push(nil)
        end
      end
    end
    

    puts @all_player_spots.inspect
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

  #To be used upon deletion of a group, destroy all tournaments associated with it
  def destroy

  end

  #Updating the tournament champion
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
