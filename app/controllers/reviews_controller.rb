class ReviewsController < ApplicationController
  
  def index
    @places = Place.where(area_name: params[:format]).includes(:reviews)
  end
end
