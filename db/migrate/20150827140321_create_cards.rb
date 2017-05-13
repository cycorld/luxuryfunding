class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :chapter_id, null: false
      t.string :question, null: false
      t.string :answer, null: false
      t.string :q_lang, default: "en"
      t.string :a_lang, default: "ko"

      t.timestamps null: false
    end
    add_index :cards, :chapter_id
  end
end
