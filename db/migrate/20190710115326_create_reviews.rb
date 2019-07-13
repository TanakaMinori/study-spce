class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :place_id
      t.string  :category
      t.text  :text
      t.integer :recommend_rate
      t.integer  :wifi_rate
      t.timestamps
    end
  end
end
