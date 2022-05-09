class GenresController < ApplicationController

  def index
    @genre = Genre.all
  end

  def show
    @genre = Genre.find_by(slug: params[:id])
  end

end
