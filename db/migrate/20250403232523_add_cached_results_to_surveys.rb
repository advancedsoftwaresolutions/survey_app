class AddCachedResultsToSurveys < ActiveRecord::Migration[7.1]
  def change
    add_column :surveys, :yes_percent, :integer
    add_column :surveys, :no_percent, :integer
    add_column :surveys, :responses_count, :integer
  end
end
