class Schedule < ApplicationRecord

  #    instant: {承認制: 0, すぐに予約: 1}
  enum instant: {Request: 0, Instant: 1}

  belongs_to :user
  has_many :reserves, dependent: :destroy
  mount_uploader :image, ScheduleImageUploader

  has_many :notifications, dependent: :destroy

  def create_notification_reserve!(current_user)
    save_notification_reserve!(current_user, reserve_id, user_id)
  end

  def save_notification_reserve!(current_user, reserve_id, visited_id)
    notification = current_user.active_notifications.new(
      schedule_id: id,
      reserve_id: reserve_id,
      visited_id: visited_id,
      action: 'reserve'
    )
    notification.save if notification.valid?
  end

end
