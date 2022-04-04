class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable,
          :omniauthable, omniauth_providers:[:twitter, :google_oauth2],
          :authentication_keys => [:login]
          # :confirmable,

  validates :band, inclusion: [true, false]
  # validates :username, presence: true, length: { maximum: 15 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9]+\z/i, message: "ユーザー名は半角英数字です" }

  attr_writer :login
  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # SNS認証
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"] 
          # OR auth["info"]["first_name"]
      user.email = auth["info"]["email"]
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.password = Devise.friendly_token[0, 20]
      end
    else
      super
    end
  end

  # enum role: { fan: 0, band: 1 }

  has_one :profile, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :discs, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :movies, dependent: :destroy

  # フォローする側から中間テーブルへのアソシエーション
  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  # フォローする側からフォローされたユーザを取得する
  has_many :followings, through: :relationships, source: :follower
  # フォローされる側から中間テーブルへのアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # フォローされる側からフォローしているユーザを取得する
  has_many :followers, through: :reverse_of_relationships, source: :following
  # あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end


  # def self.find_for_oauth_google(auth)
  #   user = User.where(uid: auth.uid, provider: auth.provider).first
  #   unless user
  #     user = User.create(
  #       provider: auth.provider,
  #       uid:      auth.uid,
  #       username: auth.info.name,
  #       email:    auth.info.email,
  #       password: Devise.friendly_token[0, 20]
  #     )
  #     profile = Profile.create(
  #       user_id: user.id,
  #       name: user.username
  #     )
  #   end
  #   # user.skip_confirmation!
  #   user
  # end
  
  # private
  # def self.dummy_email(auth)
  #   "#{auth.uid}-#{auth.provider}@example.com"
  # end
end
