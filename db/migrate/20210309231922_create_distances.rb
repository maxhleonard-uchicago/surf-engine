class CreateDistances < ActiveRecord::Migration[6.0]
  def change
    create_table :distances do |t|
      t.string :origin
      t.string :destination
      t.integer :distance
      t.integer :duration

      t.timestamps
    end
  end
end
