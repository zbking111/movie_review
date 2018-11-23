class CreateListFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :list_films do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :list_id

      t.timestamps
    end
  end
end
