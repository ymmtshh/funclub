class DiscsController < ApplicationController
  before_action :find_disc, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @disc = Disc.new
  end

  def edit
  end

  def create
    @disc = Disc.new(disc_params)
    @disc.user_id = current_user.id
    if @disc.save
      redirect_to disc_path(@disc), notice: "DISCOGRAPHYを作成しました。"
    else
      render :new
    end
  end

  def update
    if @disc.update(disc_params)
      redirect_to disc_path(@disc), notice: "DISCOGRAPHYを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @disc.destroy
      redirect_to discs_user_path(@disc.user_id), notice: "DISCOGRAPHYを削除しました。"
    else
      redirect_to discs_user_path(@disc.user_id), alert: "DISCOGRAPHYを削除できませんでした。"
    end
  end

  private

  def disc_params
    params.require(:disc).permit(
      :title,
      :release,
      :price,
      :body,
      :image,
      :image_cache,
      :remove_image,
      :published_date
    )
  end

  def find_disc
    @disc = Disc.find(params[:id])
  end
end
