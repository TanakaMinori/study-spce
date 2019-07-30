class Place < ApplicationRecord
  has_many :reviews, :dependent => :destroy
  
  accepts_nested_attributes_for :reviews
  def review_average
    self.reviews.average(:recommend_rate).round
  end
  def wifi_average
    self.reviews.average(:wifi_rate).round
  end
end
