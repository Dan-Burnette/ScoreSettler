class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :tournaments

  validates :name, presence: true
end
