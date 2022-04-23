class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  belongs_to :city

  mount_uploader :avatar, ProfileAvatarUploader

end
