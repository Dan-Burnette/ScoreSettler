class Match < ActiveRecord::Base
  attr_accessor :player_1, :player_2, :winner_id
  belongs_to :tournament
end
