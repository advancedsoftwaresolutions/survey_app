class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :question
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
