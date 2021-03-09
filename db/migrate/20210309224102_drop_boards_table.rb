class DropBoardsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :boards
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
