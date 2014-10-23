class TournamentsController < ApplicationController
  before_action :authenticate_user!

  #Show all tournaments on the user
  def index
  end


 #Create tournament, randomize players, make its matches, redirect to it's view if successful
  def create
    #Setting up the players 
    player_names = params[:players]
    player_count = player_names.size
    if (player_count <= 4)
      byes = 4 - player_count
      t_size = 4
    elsif (player_count <= 8)
      byes = 8 - player_count
      t_size = 8
    elsif (player_count <= 16)
      byes = 16 - player_count
      t_size = 16
    else
      t_size = 'too big'
    end
    puts "tournament size is" + "#{t_size}"
    byes.times { player_names.push("bye") }
    player_names.shuffle!
    puts "#{player_names}"

    #Actual tournament creation
    if (t_size != 'too big')
      tournament = Tournament.new(tournament_params)
      tournament.size = t_size
      if (tournament.save)
        session[:players] = player_names
        redirect_to tournament_path(tournament.id)
      else
        #error did not save !
      end
    else
      #error t_size too big
    end

    #Match setup
    if (tournament != nil)
      #Create all  matches for the tournament
      (t_size-1).times {tournament.matches.create()}
      puts tournament.matches
      #populate the first round with players
      players = []
      player_names.each do |p|
       found = players.push(User.find_by(username: p))
      end
      ind = 0
      for i in 0...t_size/2
        #if nil, means that the spot is a bye, not a player
        if (players[ind] != nil)
          tournament.matches[i].update(player_1: players[ind].id)
        end
        if (players[ind+1] != nil)
          tournament.matches[i].update(player_2: players[ind+1].id)
        end
        ind += 2
      end
    end

  end

  #Only to be used on in progress tournaments 
  def show
    @tournament = Tournament.find(params[:id])
    @matches = @tournament.matches
    #If tournament was just created we have the players
    @players = []
    @matches.each do |m|
      p1 = User.find_by(id: m.player_1.to_i)
      if (p1 != nil)
        @players.push(p1.username)
      else
        @players.push("bye")
      end
      p2 = User.find_by(id: m.player_2.to_i)
      if (p2 != nil)
        @players.push(p2.username)
      else
        @players.push("bye")
      end
    end

    #send in the names in order of where they should be
    #so that they can be populated in 
    #the view if tournament is in progress
    @all_player_spots = [];
    for i in 0...@tournament.size-1
      p1 = User.find_by(id: (@matches[i].player_1.to_i))
      p2 = User.find_by(id: (@matches[i].player_2.to_i))
      if p1
        @all_player_spots.push(p1.username)
      else
        @all_player_spots.push(nil)
      end
      if p2
        @all_player_spots.push(p2.username)
      else
        @all_player_spots.push(nil)
      end
    end
    puts @all_player_spots.inspect

    case @tournament.size
    when 4
      render 'show_four_person_tournament'
    when 8
      render 'show_eight_person_tournament'
    when 16
      render 'show_sixteen_person_tournament'
    end
  end

  #To be used upon deletion of a group, destroy all tournaments associated with it
  def destroy

  end

  def update
    tournament = Tournament.find(params[:id])
    champion_id = User.find_by(username: params[:winner]).id
    tournament.update(champion_id: champion_id)

  end

  def tournament_params
    params.require(:tournament).permit(:game_type, :group_id, :name, :champion_id, :size)
  end

end
