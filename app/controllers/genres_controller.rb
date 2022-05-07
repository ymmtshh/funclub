class GenresController < ApplicationController

  def index
    @genre = Genre.all
  end

  def show
    Genre.find(slug: params[:id])
  end

end
