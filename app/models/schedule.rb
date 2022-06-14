class Schedule < ApplicationRecord

  #    instant: {承認制: 0, すぐに予約: 1}
  enum instant: {Request: 0, Instant: 1}

  belongs_to :user
  has_many :reserves, dependent: :destroy
  mount_uploader :image, ScheduleImageUploader

  has_many :notifications, dependent: :destroy

  def create_notification_reserve!(current_user, reserve_id)
    save_notification_reserve!(current_user, reserve_id, user_id)
  end

  def save_notification_reserve!(current_user, reserve_id, visited_id)
    notification = current_user.active_notifications.new(
      visited_id: visited_id,
      schedule_id: id,
      reserve_id: reserve_id,
      action: 'reserve'
    )
    notification.save if notification.valid?
  end

  # def create_notification_like!(current_user)
  #   # すでに「いいね」されているか検索
  #   temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
  #   # いいねされていない場合のみ、通知レコードを作成
  #   if temp.blank?
  #     notification = current_user.active_notifications.new(
  #       post_id: id,
  #       visited_id: user_id,
  #       action: 'like'
  #     )
  #     # 自分の投稿に対するいいねの場合は、通知済みとする
  #     if notification.visitor_id == notification.visited_id
  #       notification.checked = true
  #     end
  #     notification.save if notification.valid?
  #   end
  # end

end
