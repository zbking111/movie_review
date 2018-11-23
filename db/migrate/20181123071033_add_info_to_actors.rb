class AddInfoToActors < ActiveRecord::Migration[5.2]
  def change
    add_column :actors, :picture, :string
  end
end
