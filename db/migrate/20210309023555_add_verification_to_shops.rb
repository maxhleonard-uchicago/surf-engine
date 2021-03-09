class AddVerificationToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :verification, :string
  end
end
