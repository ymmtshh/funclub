class SearchesController < ApplicationController

  def search
    @profiles = Profile.search(params[:search])
  end

  # private
  # def keyword(value)
  #   Profile.where('name LIKE(?)', "%#{value}%")
  # end

  # def match_prefecture(value)
  #   Profile.where(prefecture_id: value)
  # end

  # def match_genre(value)
  #   Profile.where(id: ProfileGenre.select(:profile_id)
  #   .where(genre_id: value)
  #   .group(:profile_id))
  # end

  # def search_for(how, value)
  #   case how
  #   when 'match_prefecture'
  #     match_prefecture(value)
  #   when 'match_genre'
  #     match_genre(value)
  #   else
  #     keyword(value)
  #   end
  # end

end
