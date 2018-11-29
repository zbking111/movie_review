class AddSubIdToNotis < ActiveRecord::Migration[5.2]
  def change
    add_column :notis, :sub_id, :integer
  end
end
