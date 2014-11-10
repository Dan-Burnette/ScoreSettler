class SetupMatches

  def self.run(tournament, t_size, player_names)
    if (tournament != nil)
      #Create all  matches for the tournament
      if (!tournament.double_elim)
        (t_size-1).times {tournament.matches.create()}
      elsif (tournament.double_elim)
        (t_size*2 - 1).times {tournament.matches.create()}
      end

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

end