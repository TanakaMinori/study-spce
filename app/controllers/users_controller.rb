class UsersController < ApplicationController
  def show
    @reviews = Review.where(user_id: current_user.id).includes(:place).order("updated_at DESC").page(params[:page]).per(3)
    @total_reviews_num = Review.where(user_id: current_user.id).length
  end

end
