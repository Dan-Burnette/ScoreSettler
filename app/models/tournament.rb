class Tournament < ActiveRecord::Base
  belongs_to :group
  has_many :matches
end
