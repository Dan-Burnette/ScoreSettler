class TournamentsController < ApplicationController
  before_action :authenticate_user!

  #Show all tournaments on the user
  def index
  end

  def create
  end


  #If completed (ie has a winner_id), show the results, else show the tournament 
  def show
  end



  #To be used upon deletion of a group, destroy all tournaments associated with it
  def destroy

  end

end
