class Schedule < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ScheduleImageUploader
end
