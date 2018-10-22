class ChangeScoreToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :rate_score, :float
  end
end
