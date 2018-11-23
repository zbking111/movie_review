class CreateNotis < ActiveRecord::Migration[5.2]
  def change
    create_table :notis do |t|
      t.integer :user_id
      t.string :content
      t.string :picture
      t.integer :seen
    end
  end
end
