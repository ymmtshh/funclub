class GoodsController < ApplicationController
  before_action :find_good, only: [:show, :edit, :update, :destroy]


  def show
  end

  def new
    @user = User.find(current_user.id)
    @good = Good.new
  end

  def edit
  end

  def create
    @good = Good.new(good_params)
    @good.user_id = params[:user_id]
    if @good.save
      redirect_to good_path(@good), notice: "GOODSを作成しました。"
    else
      render :new
    end
  end

  def update
    if @good.update(good_params)
      redirect_to good_path(@good), notice: "GOODSを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @good.destroy
      redirect_to goods_user_path(@good.user_id), notice: "GOODSを削除しました。"
    else
      redirect_to goods_user_path(@good.user_id), alert: "GOODSを削除できませんでした。"
    end
  end

  private
  def find_good
    @good = Good.find(params[:id])
  end

  def good_params
    params.require(:good).permit(
      :user_id,
      :title,
      :body,
      :price,
      :image,
      :image_cache,
      :remove_image
    )
  end

end
