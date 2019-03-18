class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :answer_post_id, null: false
      t.boolean :target, null: false


      t.timestamps
    end
  end
end
