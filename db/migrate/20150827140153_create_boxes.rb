class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.integer :user_id
      t.string :title

      t.timestamps null: false
    end
  end
end
