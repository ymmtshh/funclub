class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:index]
  before_action :set_user, except: [:index]

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

  private
  def set_user
    @user = User.find(params[:id])
  end

end
