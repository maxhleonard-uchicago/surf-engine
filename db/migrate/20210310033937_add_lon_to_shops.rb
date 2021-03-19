class AddLonToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :lon, :float
  end
end
