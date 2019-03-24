class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prefecture, :integer, null: false
    add_column :users, :age, :string, null: false
    add_column :users, :sex, :integer, null: false
    add_column :users, :email, :string
  end
end
