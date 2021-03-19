class AddLogoToModel < ActiveRecord::Migration[6.0]
  def change
    add_column :models, :logo, :string
  end
end
