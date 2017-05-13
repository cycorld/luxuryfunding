class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.integer :user_id, null: false
      t.string :title, null: false

      t.timestamps null: false
    end
    add_index :boxes, :user_id
    add_index :boxes, :title
  end
end
