class AddStatusTOmatch < ActiveRecord::Migration
  def change
    add_column :matches, :status, :boolean
  end
end
