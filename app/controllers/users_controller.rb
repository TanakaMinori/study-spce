class UsersController < ApplicationController
  def show
    @reviews = Review.where(user_id: params[:id]).includes(:place).order("updated_at DESC").page(params[:page]).per(3)
    @user = @reviews.first.user
    @total_reviews_num = Review.where(user_id: current_user.id).length
  end

end
