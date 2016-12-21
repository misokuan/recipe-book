class User < ApplicationRecord
  has_secure_password
  has_many :cookbooks
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true

  enum access_level: [:cookbookers, :the_pretty_admin]

end
