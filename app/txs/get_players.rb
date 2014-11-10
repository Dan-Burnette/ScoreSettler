class GetPlayers

  def self.run(tournament, matches)
    all_player_spots = [];
    matches_to_fill = tournament.double_elim == true ? 2*tournament.size-1 : tournament.size-1

    for i in 0...matches_to_fill 
      p1 = User.find_by(id: (matches[i].player_1.to_i))
      p2 = User.find_by(id: (matches[i].player_2.to_i))
      if p1 != nil
        all_player_spots.push(p1.username)
      else
        all_player_spots.push(nil)
      end
      if p2 != nil
        all_player_spots.push(p2.username)
      else
        all_player_spots.push(nil)
      end
    end

    all_player_spots
  end

end