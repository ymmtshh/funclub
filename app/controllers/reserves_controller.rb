class ReservesController < ApplicationController

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
      reserve = current_user.reserves.new(reserve_params)
      reserve.schedule_id = schedule.id
      reserve.save
      redirect_to user_schedule_path(schedule.user, schedule)
    end
  
    def destroy
      reserve = Reserve.find(params[:id])
      reserve.destroy
      redirect_to user_reserves_path(current_user.id) 
    end
  
    private
  
    def reserve_params
      params.require(:reserve).permit(
        :name,
        :number,
        :body
      )
    end

end
