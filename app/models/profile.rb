class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  
  has_many :profile_genres, dependent: :destroy, foreign_key: 'profile_id'
  has_many :genres, through: :profile_genres
  # accepts_nested_attributes_for :profile_genres, allow_destroy: true
  attr_accessor :genre_ids

  has_one :social_profile, dependent: :destroy
  accepts_nested_attributes_for :social_profile

  mount_uploader :avatar, ProfileAvatarUploader

  validates :name, presence: true
  validates :prefecture_id, presence: true

  def self.search(search)
    if search
      patterns = search.split(/[ , ]/)
      sql_name = ''
      patterns.each do | pattern |
        sql_name += ' and ' unless sql_name.blank?
        sql_name += " name like '%#{Profile.sanitize_sql_like(pattern)}%' "
      end
      sql = "select * from profiles where #{sql_name} order by id desc"
      profile_ids = Profile.find_by_sql(sql)
      ids = []
      profile_ids.each do |qi|
        ids.push(qi.id)
      end
      where(:id => ids)
    else
      Profile.all
    end
  end
  
end
