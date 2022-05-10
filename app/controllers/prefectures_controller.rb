class PrefecturesController < ApplicationController

  def index
    @prefecture = Prefecture.all
  end

  def show
    @prefecture = Prefecture.find_by(slug: params[:id])
    @prefectures = Prefecture.where(slug: params[:id]).includes(profiles: :user)
  end

end
