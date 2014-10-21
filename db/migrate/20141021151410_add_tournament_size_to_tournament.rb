class AddTournamentSizeToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :size, :integer
  end
end
