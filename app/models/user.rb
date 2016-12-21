class User < ApplicationRecord
  has_secure_password
  has_many :cookbooks
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true

  enum access_level: [:cookbookers, :the_pretty_admin]

def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = SecureRandom.urlsafe_base64
      if auth.info.email != nil
        user.username = auth.info.email[/[^@]+/]
      else
        user.username = auth.info.nickname
      end
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end  

end
