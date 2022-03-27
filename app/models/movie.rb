class Movie < ApplicationRecord
  belongs_to :user
  # validates :title, :video, presence: true
  mount_uploader :video, VideoUploader
end
