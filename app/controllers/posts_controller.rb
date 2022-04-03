class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  # before_action :user, except: [:show]

  def show
  end
  
  def new
    @post = Post.new
  end
  
  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "NEWSを作成しました。"
    else
      render :new
    end
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "NEWSを更新しました。"
    else
      render :edit
    end
  end
  
  def destroy
    if @post.destroy
      redirect_to posts_user_path(@post.user_id), notice: "NEWSを削除しました。"
    else
      redirect_to posts_user_path(@post.user_id), alert: "NEWSを削除できませんでした。"
    end
  end
  
  private
  # def user
  #   redirect_to(root_url) unless current_user.band?
  # end
  
  def find_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(
      :title,
      :body,
      :image,
      :image_cache,
      :remove_image
    )
  end
end