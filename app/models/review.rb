class Review < ApplicationRecord
  belongs_to :place, dependent: :destroy
  
  def review_average
    self.reviews.average(:rate).round
  end
end
