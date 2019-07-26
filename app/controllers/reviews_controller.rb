class ReviewsController < ApplicationController
  
  def index
    @places = Place.where(area_name: params[:format]).includes(:reviews)
  end
  
  def search
    keyword = "%#{params[:keyword]}%"
    @places = Place.where('address LIKE(?)', keyword)
  end
end
