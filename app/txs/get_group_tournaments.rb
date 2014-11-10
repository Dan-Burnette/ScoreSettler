class GetGroupTournaments

  def self.run(group)

    tournaments = group.tournaments
    complete_tournaments = []
    champs = []
    incomplete_tournaments = []

    tournaments.each do |t|
      if (t.champion_id == nil)
        incomplete_tournaments.push(t)
      else
        complete_tournaments.push(t)
        champ = User.find(t.champion_id)
        champs.push(champ)
      end
    end

    {
      :complete_tournaments => complete_tournaments,
      :incomplete_tournaments => incomplete_tournaments,
      :champs => champs
    }

  end

end
