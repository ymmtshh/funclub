module NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @reserve = nil
    @visitor_reserve = notification.reserve_id
    case notification.action
    when 'follow'
      tag.a(@visitor.profile.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'reserve' then      
      @reserve = Reserve.find_by(id: @visitor_reserve)
      @reserve_content =@reserve.body
      @schedule_title =@reserve.schedule.title
      tag.a(@visitor.profile.name, href: user_path(@visitor)) + 'が' + tag.a("#{@schedule_title}", href: user_schedule_path(notification.schedule_id)) + 'を予約しました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
