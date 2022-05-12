class SearchesController < ApplicationController

  def search
    @profiles = Profile.search(params[:search])
  end

end
