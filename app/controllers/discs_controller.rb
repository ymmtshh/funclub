class DiscsController < ApplicationController
  before_action :find_disc, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @discs = @user.discs.order(created_at: :desc).all
  end

  def show
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.find(current_user.id)
    @disc = Disc.new
  end

  def edit
  end

  def create
    @disc = Disc.new(disc_params)
    @disc.user_id = params[:user_id]
    if @disc.save
      redirect_to user_discs_path(current_user.id), notice: "DISCOGRAPHYを作成しました。"
    else
      render :new
    end
  end

  def update
    if @disc.update(disc_params)
      redirect_to user_disc_path(current_user.id, @disc), notice: "DISCOGRAPHYを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @disc.destroy
      redirect_to user_discs_path(current_user.id), notice: "DISCOGRAPHYを削除しました。"
    else
      redirect_to user_discs_path(current_user.id), alert: "DISCOGRAPHYを削除できませんでした。"
    end
  end

  private
  def find_disc
    @disc = Disc.find(params[:id])
  end

  def disc_params
    params.require(:disc).permit(
      :user_id,
      :title,
      :published_date,
      :price,
      :body,
      :image,
      :image_cache,
      :remove_image
    )
  end
end
