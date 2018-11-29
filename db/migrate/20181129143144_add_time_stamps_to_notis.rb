class AddTimeStampsToNotis < ActiveRecord::Migration[5.2]
  def change
    add_column :notis, :created_at, :datetime
    add_column :notis, :updated_at, :datetime
  end
end
