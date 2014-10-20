class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|

      t.integer :champion_id
      t.string :game_type
      t.integer :group_id

      t.timestamps
    end
  end
end
