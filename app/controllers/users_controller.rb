class UsersController < ApplicationController
  before_action :authenticate_user!,only: [:index]
  before_action :set_user

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @users = User.find(params[:id])
    @likes = Like.where(user_id: current_user.id)
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes) 
  end

  def contacts
    @contacts = @user.contacts
    # redirect_to  controller: :contacts, action: :new
  end

  def withdrawal
    @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

end
