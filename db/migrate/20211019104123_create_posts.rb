class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :title, null: false
      t.text :content
      t.boolean :premium

      t.timestamps
    end
  end
end
