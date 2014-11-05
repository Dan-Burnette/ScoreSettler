class AddDoubleElimToTournament < ActiveRecord::Migration
  def change
     add_column :tournaments, :double_elim, :boolean
  end
end
