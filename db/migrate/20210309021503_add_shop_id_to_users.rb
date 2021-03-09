class AddShopIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :shop_id, :integer
  end
end
