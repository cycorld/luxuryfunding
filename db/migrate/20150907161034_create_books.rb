class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :intro

      t.timestamps null: false
    end
    add_index :books, :user_id
    add_index :books, :title
  end
end
