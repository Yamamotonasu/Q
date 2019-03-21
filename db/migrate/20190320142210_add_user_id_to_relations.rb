class AddUserIdToRelations < ActiveRecord::Migration[5.2]
  def change
    add_reference :relations, :user, foreign_key: true
  end
end
