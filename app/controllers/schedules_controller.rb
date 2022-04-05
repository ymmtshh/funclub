class SchedulesController < ApplicationController
  before_action :find_schedule, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @schedule = Schedule.new
  end

  def edit
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
      redirect_to schedule_path(@schedule), notice: "スケジュールを作成しました。"
    else
      render :new
    end
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedule_path(@schedule), notice: "スケジュールを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @schedule.destroy
      redirect_to schedules_user_path(@schedule.user_id), notice: "スケジュールを削除しました。"
    else
      redirect_to schedules_user_path(@schedule.user_id), alert: "スケジュールを削除できませんでした。"
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(
      :title,
      :body,
      :image,
      :image_cache,
      :remove_image,
      :schedule_date,
      :open_time,
      :start_time
    )
  end

  def find_schedule
    @schedule = Schedule.find(params[:id])
  end

end
