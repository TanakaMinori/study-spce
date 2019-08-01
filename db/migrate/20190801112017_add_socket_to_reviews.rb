class AddSocketToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :socket, :string
  end
end
