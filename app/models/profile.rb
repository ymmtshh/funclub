class Profile < ApplicationRecord
  belongs_to :user
  # belongs_to :prefecture
  # validates :name, presence: true
  mount_uploader :avatar, ProfileAvatarUploader

end
