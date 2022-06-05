class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new(user_id: current_user.id)
    if like.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user_id: current_user.id)
    if like.present?
        like.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end
end

