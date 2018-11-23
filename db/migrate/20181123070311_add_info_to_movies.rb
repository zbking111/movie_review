class AddInfoToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :category, :string
    add_column :movies, :nation, :string
    add_column :movies, :duration, :integer
    add_column :movies, :trailer, :string
  end
end
