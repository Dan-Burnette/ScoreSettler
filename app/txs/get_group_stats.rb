class GetGroupStats

  def self.run(group)

    #Only grab group users with active memberships (not pending)
    group_users = []
    group.users.each do |u|
      membership = Membership.where("user_id = ? AND group_id = ? AND status = ?", u.id, group.id, "active")[0]
      if (membership != nil)
        group_users.push(u)
      end
    end

    all_user_wins = []
    all_user_losses = []
    all_user_win_loss_ratios = []
    all_user_tournament_wins = []

    #Initialize wins/losses to 0 for each user, and grab their tournament wins
    group_users.each do |user|
       all_user_wins.push(0)
       all_user_losses.push(0)
       user_tournament_wins = Tournament.where("champion_id = ? AND group_id = ?", user.id, group.id).count
       all_user_tournament_wins.push(user_tournament_wins)
    end

    #Count up all the wins/losses for each user in this group's tournaments
    group.tournaments.each_with_index do |t, i|
      group_users.each_with_index do |user, j|
        #Check for nils because we don't want to count bye matches as wins for that player
        user_match_wins = Match.where("winner_id = ? AND tournament_id = ?", user.id, t.id).where.not(player_1: nil).where.not(player_2: nil).count
        all_user_wins[j] += user_match_wins
        user_match_losses = Match.where("player_1 = ? OR player_2 = ?" , user.id, user.id).where("tournament_id = ?", t.id).where.not("winner_id = ?", user.id).count
        all_user_losses[j] += user_match_losses       
      end
    end

    #Calculate win/loss ratio for each user 
    group_users.each_with_index do |user, i|
      user_match_wins = all_user_wins[i]
      user_match_losses = all_user_losses[i]
      if (user_match_losses == 0)
        user_win_loss_ratio = "Unbeatable"
        if (user_match_wins == 0)
          user_win_loss_ratio = 0.0
        end
      else
        user_win_loss_ratio = ((user_match_wins.to_f/user_match_losses.to_f)*100).to_i / 100.0
      end
      all_user_win_loss_ratios.push(user_win_loss_ratio)
    end

    {:group_users => group_users,
     :all_user_wins => all_user_wins, 
     :all_user_losses => all_user_losses,
     :all_user_win_loss_ratios => all_user_win_loss_ratios,
     :all_user_tournament_wins => all_user_tournament_wins}

  end
  
end