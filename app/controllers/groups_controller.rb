class GroupsController < ApplicationController
  before_action :authenticate_user!

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

    #Get the tournaments for that group
    tournaments = GetGroupTournaments.run(@group)
    @complete_tournaments = tournaments[:complete_tournaments]
    @incomplete_tournaments = tournaments[:incomplete_tournaments]
    @champs = tournaments[:champs]
    
    #Get stats for that group
    stats = GetGroupStats.run(@group)
    @group_users = stats[:group_users]
    @all_user_wins = stats[:all_user_wins]
    @all_user_losses = stats[:all_user_losses]
    @all_user_win_loss_ratios = stats[:all_user_win_loss_ratios]
    @all_user_tournament_wins = stats[:all_user_tournament_wins]

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

      stats = GetHeadToHeadStats.run(group_id, username1, username2)
      @meetings = stats[:meetings]
      @victories = stats[:victories]
      @defeats = stats[:defeats]
    end

  end

  def group_params
    params.require(:group).permit(:name, :admin_id)
  end


end
