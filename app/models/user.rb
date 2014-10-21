class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #For adding the ability to log in with username instead of just email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }#,
  # :format => { } # etc.

end
