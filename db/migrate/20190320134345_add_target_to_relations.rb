class AddTargetToRelations < ActiveRecord::Migration[5.2]
  def change
    add_column :relations, :target, :boolean, default: false, null: false
  end
end
