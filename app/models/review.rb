class Review < ApplicationRecord
  belongs_to :place, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_one_attached :image
  
  def review_average
    self.reviews.average(:rate).round
  end
end
