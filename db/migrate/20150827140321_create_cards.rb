class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :box_id
      t.string :question
      t.string :answer
      t.integer :stage

      t.timestamps null: false
    end
  end
end
