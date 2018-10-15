class RemoveDateFromMovie < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :date, :integer
  end
end
