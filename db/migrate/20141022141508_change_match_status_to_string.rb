class ChangeMatchStatusToString < ActiveRecord::Migration
  def change
    change_column :matches, :status, :string
  end
end
