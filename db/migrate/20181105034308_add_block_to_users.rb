class AddBlockToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :detective, :integer, default: 0
  end
end
