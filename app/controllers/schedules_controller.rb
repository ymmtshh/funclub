class SchedulesController < ApplicationController
  before_action :find_schedule, only: [:show, :edit, :update, :destroy]

  def show
    @comments = @schedule.comments.includes(:user).all
    @comment  = @schedule.comments.build(user_id: current_user.id) if current_user
  end

  def new
    @user = User.find(current_user.id)
    @schedule = Schedule.new
  end

  def edit
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = params[:user_id]
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
  def find_schedule
    @schedule = Schedule.includes(:user).find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(
      :user_id,
      :title,
      :body,
      :image,
      :image_cache,
      :remove_image,
      :schedule_date,
      :open_time,
      :start_time,
      :comment_content
    )
  end


end
