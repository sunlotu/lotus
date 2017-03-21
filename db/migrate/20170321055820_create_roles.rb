class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :roles, :code
  end
end
