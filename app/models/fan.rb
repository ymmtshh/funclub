class Fan < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable,
  :authentication_keys => [:login]
  # :confirmable,

  def self.find_for_oauth(auth)
  fan = Fan.where(uid: auth.uid, provider: auth.provider).first

  unless fan
    fan = Fan.create(
      provider: auth.provider,
      uid:      auth.uid,
      username: auth.uid,
      email:    Fan.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
  end
  # user.skip_confirmation!
  fan
end

private
def self.dummy_email(auth)
  "#{auth.uid}-#{auth.provider}@example.com"
end
end
