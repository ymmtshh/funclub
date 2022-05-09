class PrefecturesController < ApplicationController

  def index
    @prefecture = Prefecture.all
  end

  def show
    @prefecture = Prefecture.find_by(slug: params[:id])
    profile = Profile.where(slug: params[:id])
    @user = @user.profile
  end

end
