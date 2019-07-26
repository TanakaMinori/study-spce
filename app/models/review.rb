class Review < ApplicationRecord
  belongs_to :place, dependent: :destroy
  has_one_attached :image
  
  def review_average
    self.reviews.average(:rate).round
  end
end
