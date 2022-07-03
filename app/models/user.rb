class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :confirmable, 
          :recoverable, :rememberable, :lockable, :timeoutable, :trackable,
          :omniauthable, omniauth_providers: %i[twitter google_oauth2],
          authentication_keys: [:login]

  validates :band, inclusion: { in: [true, false] }
  validates :username, presence: true, length: { maximum: 15 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9_-]+\z/i, message: "ユーザー名は半角英数字です" }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'


  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :schedules, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :discs, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_many :reserves, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following


  # usernameのみでログイン
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

  # SNS認証
    def self.from_omniauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user.present?
      provider = auth.provider
      if provider == "twitter"
        if auth.email.nil?
          user = User.new(
            provider: auth.provider,
            uid:      auth.uid,
            username: auth.info.nickname,
            email:    auth.info.email,
            password: Devise.friendly_token[0, 20]
          )
        else
          user = User.new(
            provider: auth.provider,
            uid:      auth.uid,
            username: auth.info.nickname,
            email:    "#{auth.uid}_#{auth.provider}@example.com",
            password: Devise.friendly_token[0, 20]
          )
        end
      end
      if provider == "google_oauth2"
        user = User.new(
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email,
          username: auth.info.email.sub(/@gmail.*/m, ''),
          password: Devise.friendly_token[0, 20]
        )
      end
      user.skip_confirmation!
      user.save
    end
    return {user: user}
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  def active_for_authentication?
    super && confirmed?
  end

  def inactive_message
    confirmed? ? super : :needs_confirmation
  end

  # def send_on_create_confirmation_instructions
  #   generate_confirmation_token!  unless @raw_confirmation_token
  #   send_devise_notification(:confirmation_on_create_instructions, @raw_confirmation_token, {})
  # end

  # def send_devise_notification(notification, *args)
  #   devise_mailer.send(notification, self, *args).deliver_later
  # end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(follower_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
