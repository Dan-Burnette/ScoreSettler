class SetupPlayers

  def self.run(player_names)
    player_count = player_names.size
    if (player_count <= 4)
      byes = 4 - player_count
      t_size = 4
    elsif (player_count <= 8)
      byes = 8 - player_count
      t_size = 8
    else
      byes = 0
      t_size = 'too big'
    end
    
    #Put in the correct number of byes and randomize 
    byes.times { player_names.push("bye") }
    player_names.shuffle!

    {
      :player_names => player_names,
      :t_size => t_size
    }

  end


end