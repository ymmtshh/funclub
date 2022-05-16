class UsersController < ApplicationController
  before_action :authenticate_user!,only: [:index]
  before_action :find_user, only: [
    :show, 
    :schedules,
    :posts,
    :discs,
    :goods,
    :movies,
    :contacts
  ]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @users = User.find(params[:id])
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def schedules
    @schedules = @user.schedules
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
  def find_user
    @user = User.find(params[:id])
  end

end
