class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture

  mount_uploader :avatar, ProfileAvatarUploader

end
