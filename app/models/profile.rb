class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  belongs_to :genre
  has_one :social_profile, dependent: :destroy
  accepts_nested_attributes_for :social_profile

  mount_uploader :avatar, ProfileAvatarUploader

end
