class AddDateToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :date, :date
  end
end
