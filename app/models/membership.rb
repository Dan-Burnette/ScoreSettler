class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  #Stop duplicate memberships
  validates :user_id, uniqueness: {scope: :group_id }
end
