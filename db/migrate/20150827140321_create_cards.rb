class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :box_id, null: false
      t.string :question, null: false
      t.string :answer, null: false
      t.integer :stage, default: 1

      t.timestamps null: false
    end
  end
end
