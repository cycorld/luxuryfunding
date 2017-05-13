class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :book_id, null: false
      t.string :title, null: false

      t.timestamps null: false
    end
    add_index :chapters, :book_id
  end
end
