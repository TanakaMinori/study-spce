class UsersController < ApplicationController
  def show
    @reviews = Review.where(user_id: params[:id]).includes(:place).order("updated_at DESC").page(params[:page]).per(3)
    @user = User.find(params[:id])
    @total_reviews_num = @user.reviews.count
  end

end
