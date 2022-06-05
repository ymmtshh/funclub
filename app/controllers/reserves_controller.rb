class ReservesController < ApplicationController
  before_action :set_reserve, only: [:approve, :decline]

    def index
      @lives = current_user.reserves.order(created_at: :desc).all
    end

    def reservations
      @schedules = current_user.schedules
    end

    def new
      @user = User.find(current_user.id)
      @schedule = Schedule.new
    end

    def create
      schedule = Schedule.find(params[:schedule_id])
      @reserve = current_user.reserves.new(reserve_params)
      @reserve.schedule = schedule
      @reserve.save
      if @reserve.save
        @reserve.schedule.create_notification_reserve!(current_user, @reserve.id)
        if schedule.Request?
          flash[:notice] = "予約リクエストを送信しました。承認されるまでしばらくお待ちください。"
        else
          @reserve.Approved!
          flash[:notice] = "予約が完了しました。"
        end
      else
        flash[:alert] = "予約できませんでした。"
      end
      redirect_to user_schedule_path(schedule.user, schedule)
    end

    def approve
      @reserve.Approved!
      redirect_to user_reservations_path(current_user.id)
    end
    def decline
      @reserve.Declined!
      redirect_to user_reservations_path(current_user.id)
    end
  
  
    def destroy
      reserve = Reserve.find(params[:id])
      reserve.destroy
      redirect_to user_reserves_path(current_user.id) 
    end
  
    private

    def set_reserve
      @reserve = Reserve.find(params[:id])
    end
  
    def reserve_params
      params.require(:reserve).permit(
        :name,
        :number,
        :body
      )
    end

end
