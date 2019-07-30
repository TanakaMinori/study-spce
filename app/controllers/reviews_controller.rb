class ReviewsController < ApplicationController
  
  before_action  :authenticate_user!, only: [:destroy]
  
  def index
    places = Place.where(area_name: params[:format]).includes(:reviews)
    @places = places.reject{|place| place.reviews.blank? }
    
  end
  
  def search
    keyword = "%#{params[:keyword]}%"
    @places = Place.where('address LIKE(?)', keyword)
  end
  
  def destroy
    review = Review.find(params[:id])
    review.delete
    redirect_back(fallback_location: user_path)
  end
end
