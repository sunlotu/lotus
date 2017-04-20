class AddAttrsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :status, :integer, default: 0
    add_index :users, :name, unique: true
  end
end
