class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, default: nil
      t.string :filename
      t.string :qiniu_hash

      t.timestamps
    end
  end
end
