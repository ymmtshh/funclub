class Schedule < ApplicationRecord

  #    instant: {承認制: 0, すぐに予約: 1}
  enum instant: {Request: 0, Instant: 1}

  belongs_to :user
  has_many :reserves, dependent: :destroy
  mount_uploader :image, ScheduleImageUploader

end
