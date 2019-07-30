class Review < ApplicationRecord
  belongs_to :place
  belongs_to :user, dependent: :destroy
  has_one_attached :image
  
  
end
