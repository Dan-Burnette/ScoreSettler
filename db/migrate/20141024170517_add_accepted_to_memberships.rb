class AddAcceptedToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :status, :boolean
  end
end
