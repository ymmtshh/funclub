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

end
