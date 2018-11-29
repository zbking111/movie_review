class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :list_id  # 1 or 2 or 3
      t.integer :movie_id
      t.timestamps
    end
  end
end
