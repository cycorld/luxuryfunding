class AddLangToCards < ActiveRecord::Migration
  def change
    add_column :cards, :q_lang, :string, default: "ko"
    add_column :cards, :a_lang, :string, default: "en"
  end
end
