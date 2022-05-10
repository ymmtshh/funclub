class GenresController < ApplicationController

  def index
    @genre = Genre.all
  end

  def show
    @genre = Genre.find_by(slug: params[:id])
    @genres = Genre.where(slug: params[:id]).includes(profiles: :user)
  end

end
