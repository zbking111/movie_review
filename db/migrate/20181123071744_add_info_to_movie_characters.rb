class AddInfoToMovieCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_characters, :role, :string
  end
end
