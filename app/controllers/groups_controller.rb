class GroupsController < ApplicationController
  before_action :authenticate_user!

  #page for finding your friend's groups to apply for a membership 
  def index
  end


  #for creating a new group
  def create
    group = Group.new(group_params)
    if (group.save)
      #need to also create your own membership
      Membership.create(user_id: current_user.id, group_id: group.id, status: "active")
      redirect_to user_path(current_user.id)
    else
      #error
    end
  end

  #For showing a specific group page.
  def show
    @group = Group.find(params[:id])

    # Tournament getting logic
    tournaments = @group.tournaments
    @complete_tournaments = []
    @champs = []
    @incomplete_tournaments = []
    tournaments.each do |t|
      if (t.champion_id == nil)
        @incomplete_tournaments.push(t)
      else
        @complete_tournaments.push(t)
        champ = User.find(t.champion_id)
        @champs.push(champ)
      end
    end

    #Only grab group users with active memberships (not pending)
    @group_users = []
    @group.users.each do |u|
      membership = Membership.where("user_id = ? AND group_id = ? AND status = ?", u.id, @group.id, "active")[0]
      if (membership != nil)
        @group_users.push(u)
      end
    end

    #STATS getting logic
    @all_user_wins = []
    @all_user_losses = []
    @all_user_win_loss_ratios = []
    @all_user_tournament_wins = []

    @group_users.each do |user|
       @all_user_wins.push(0)
       @all_user_losses.push(0)
       user_tournament_wins = Tournament.where("champion_id = ? AND group_id = ?", user.id, @group.id).count
       @all_user_tournament_wins.push(user_tournament_wins)
    end

    @group.tournaments.each_with_index do |t, i|
      @group_users.each_with_index do |user, j|
        #Check for nils because we don't want to count bye matches as wins for that player
        user_match_wins = Match.where("winner_id = ? AND tournament_id = ?", user.id, t.id).where.not(player_1: nil).where.not(player_2: nil).count
        @all_user_wins[j] += user_match_wins
        user_match_losses = Match.where("player_1 = ? OR player_2 = ?" , user.id, user.id).where("tournament_id = ?", t.id).where.not("winner_id = ?", user.id).count
        @all_user_losses[j] += user_match_losses       
      end
    end

    #Calculate win/loss ratio. Need to avoid divide by zero error
    @group_users.each_with_index do |user, i|
      user_match_wins = @all_user_wins[i]
      user_match_losses = @all_user_losses[i]
      if (user_match_losses == 0)
        user_win_loss_ratio = "Unbeatable"
        if (user_match_wins == 0)
          user_win_loss_ratio = 0.0
        end
      else
        user_win_loss_ratio = ((user_match_wins.to_f/user_match_losses.to_f)*100).to_i / 100.0
      end
      @all_user_win_loss_ratios.push(user_win_loss_ratio)
    end

    #Render admin and user views separately
    if (current_user.id == @group.admin_id)
      render 'showGroupToAdmin'
    else
      render 'showGroupToUser'
    end
  end

  #populating the head to head table stats if the data has been sent
  def ajax_head_to_head
    if (params[:id])
      info = params[:id].split(',')
      group_id = info[0]
      username1 = info[1]
      username2 = info[2]
      puts info

      user1 = User.find_by(username: username1)
      user2 = User.find_by(username: username2)
      group = Group.find(group_id.to_i)
      @meetings = 0
      @victories = 0
      @defeats = 0
      if (group && user1 && user2)
        group.tournaments.each do |t|
          t.matches.each do |m|
            if ((m.player_1 == user1.id || m.player_1 == user2.id) && 
                (m.player_2 == user1.id || m.player_2 == user2.id))
                if (m.winner_id == user1.id)
                  @victories +=1
                else
                  @defeats +=1
                end
                @meetings +=1
            end
          end
        end
      end
      @defeats
    end
  end

  def group_params
    params.require(:group).permit(:name, :admin_id)
  end


end
