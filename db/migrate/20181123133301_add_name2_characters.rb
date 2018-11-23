class AddName2Characters < ActiveRecord::Migration[5.2]
  def change
    add_column :actors, :role, :string
  end
end
