class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable,
          :authentication_keys => [:login]
          # :confirmable,

  # validates :username,
  #           uniqueness: { case_sensitive: :false },
  #           length: { minimum: 4, maximum: 20 },
  #           format: { with: /\A[a-z0-9]+\z/, message: "ユーザー名は半角英数字です"}

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

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        provider: auth.provider,
        uid:      auth.uid,
        username: auth.uid,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
      profile = Profile.create(
        user_id: user.id,
        name: user.username
      )
    end
    # user.skip_confirmation!
    user
  end
  
  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
