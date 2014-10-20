class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|

      t.integer :winner_id
      t.integer :player_1
      t.integer :player_2

      t.timestamps
    end
  end
end
