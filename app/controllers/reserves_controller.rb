class ReservesController < ApplicationController

    def index
      @reserves = current_user.reserves.order(created_at: :desc).all
    end

    def reservation
      @schedules = current_user.schedules
    end

    def create
      schedule = Schedule.find(params[:schedule_id])
      reserve = current_user.reserves.new(reserve_params)
      reserve.schedule_id = schedule.id
      reserve.save
      redirect_to user_schedule_path(schedule.user, schedule)
    end
  
    def destroy
      reserve.find_by(id: params[:id], schedule_id: params[:schedule_id]).destroy
      redirect_to user_schedule_path(params[:schedule_id])
    end
  
    private
  
    def reserve_params
      params.require(:reserve).permit(:reserve_content)
    end

end
