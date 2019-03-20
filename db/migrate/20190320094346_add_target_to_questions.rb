class AddTargetToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :target, :boolean, default: false, null: false
  end
end
