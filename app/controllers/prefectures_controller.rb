class PrefecturesController < ApplicationController

  def index
    @prefecture = Prefecture.all
  end

  def show
    Prefecture.find(slug: params[:id])
  end

end
