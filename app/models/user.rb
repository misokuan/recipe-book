class User < ApplicationRecord
  has_secure_password
  has_many :cookbooks
  has_many :subscriptions
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true
  mount_uploader :avatar, AvatarUploader
  acts_as_birthday :date_of_birth
  enum access_level: [:cookbookers, :the_admin]

  def self.from_omniauth(auth)
    if auth.try(:provider)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        if auth.info.email == nil
          user.email = "#{auth.info.nickname}@twitter.com"
          user.username = auth.info.nickname
        else
          user.email = auth.info.email
          user.username = auth.info.email[/[^@]+/]
        end
        user.remote_avatar_url = auth.info.image.gsub('http://','https://')
        user.password = SecureRandom.urlsafe_base64
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at.to_i)
        user.save!
      end
    end
  end 

  def full_name
    if !self.first_name.blank? && !self.last_name.blank?
      return "#{self.first_name.titleize} #{self.last_name.titleize}"
    else
      return "N/A"
    end
  end

  def type_of_cooking
    if self.type_of_cook.blank?
      return "N/A"
    else
      return self.type_of_cook
    end
  end 

end
