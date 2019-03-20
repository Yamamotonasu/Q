class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.integer :answered_user_id, null: false
      t.references :question, foreign_key: true, null: false

      t.timestamps
    end
  end
end
