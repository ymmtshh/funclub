class Schedule < ApplicationRecord
  belongs_to :user
  has_many :reserves, dependent: :destroy
  mount_uploader :image, ScheduleImageUploader
end
