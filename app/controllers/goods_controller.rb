class GoodsController < ApplicationController
  before_action :find_good, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @goods = @user.goods.order(created_at: :desc).all
  end

  def search
    @user = User.find(params[:user_id])
    @goods_category_id = params[:goods_category_id]
    @goods = Good.includes(:user).where(goods_category_id: @goods_category_id )
    render :index
  end


  def show
    @user = User.find(params[:user_id])
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
      redirect_to user_goods_path(current_user.id), notice: "GOODSを作成しました。"
    else
      render :new
    end
  end

  def update
    if @good.update(good_params)
      redirect_to user_good_path(current_user.id, @good), notice: "GOODSを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @good.destroy
      redirect_to user_goods_path(current_user.id), notice: "GOODSを削除しました。"
    else
      redirect_to user_goods_path(current_user.id), alert: "GOODSを削除できませんでした。"
    end
  end

  private
  def find_good
    @good = Good.find(params[:id])
  end

  def good_params
    params.require(:good).permit(
      :user_id,
      :goods_category_id,
      :title,
      :body,
      :price,
      :image,
      :image_cache,
      :remove_image
    )
  end

end
