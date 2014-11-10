class GetHeadToHeadStats

  def self.run(group_id, username1, username2)

    user1 = User.find_by(username: username1)
    user2 = User.find_by(username: username2)
    group = Group.find(group_id.to_i)
    meetings = 0
    victories = 0
    defeats = 0
    if (group && user1 && user2)
      group.tournaments.each do |t|
        t.matches.each do |m|
          if ((m.player_1 == user1.id || m.player_1 == user2.id) && 
              (m.player_2 == user1.id || m.player_2 == user2.id))
              if (m.winner_id == user1.id)
                victories +=1
              else
                defeats +=1
              end
              meetings +=1
          end
        end
      end
    end

    {
      :victories => victories,
      :defeats => defeats,
      :meetings => meetings
    }

  end

end