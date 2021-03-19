class AddLonToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :lon, :float
  end
end
