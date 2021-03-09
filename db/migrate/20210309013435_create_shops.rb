class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :website
      t.string :logo

      t.timestamps
    end
  end
end
