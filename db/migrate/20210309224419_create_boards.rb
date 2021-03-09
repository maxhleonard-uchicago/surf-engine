class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.integer :model_id
      t.integer :length
      t.integer :width
      t.integer :thickness
      t.float :liters
      t.integer :tail
      t.integer :fin_config
      t.integer :fin_system
      t.integer :construction
      t.string :image
      t.integer :shop_id
      t.integer :individual_id
      t.boolean :owner_is_shop
      t.integer :condition
      t.boolean :artwork
      t.float :price
      t.text :notes

      t.timestamps
    end
  end
end
