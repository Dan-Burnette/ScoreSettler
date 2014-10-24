class MakeMatchStatusBeString < ActiveRecord::Migration
  def change
    change_column :memberships, :status, :string
  end
end
