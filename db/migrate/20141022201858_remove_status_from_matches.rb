class RemoveStatusFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :status
  end
end
