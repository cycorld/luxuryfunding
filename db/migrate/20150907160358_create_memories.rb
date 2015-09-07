class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.integer :box_id, null: false
      t.integer :card_id, null: false
      t.string :question, null: false
      t.string :answer, null: false
      t.string :q_lang, default: "ko"
      t.string :a_lang, default: "en"
      t.integer :stage, default: 1

      t.timestamps null: false
    end
  end
end
