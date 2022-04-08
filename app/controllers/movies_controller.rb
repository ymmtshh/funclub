class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @user = User.find(current_user.id)
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = params[:user_id]
    if @movie.save
      redirect_to movie_path(@movie), notice: "動画を投稿しました。"
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: "動画を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @movie.destroy
      redirect_to movies_user_path(@movie.user_id), notice: "動画を削除しました。"
    else
      redirect_to movies_user_path(@movie.user_id), alert: "動画を削除できませんでした。"
    end
  end

  private
  def find_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(
      :user_id,
      :title,
      :body,
      :video,
      :video_cache,
      :remove_video,
      :published_date
    )
  end
end
