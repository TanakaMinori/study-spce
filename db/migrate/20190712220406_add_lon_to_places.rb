class AddLonToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :lon, :float
    add_column :places, :lat, :float
  end
end
