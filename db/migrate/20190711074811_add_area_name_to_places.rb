class AddAreaNameToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :area_name, :string
  end
end
