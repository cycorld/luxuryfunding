class Chapter < ActiveRecord::Base
  belongs_to :book
  has_one :user, through: :book
  has_many :cards, inverse_of: :chapter
  accepts_nested_attributes_for :cards, reject_if: :all_blank, allow_destroy: true, update_only: true

  def self.import file
    require 'csv'
    result = Hash.new
    CSV.foreach(file.path, {headers: true}).with_index(1) do |r, i|
      result.merge!({"#{i}": {question: r["question"], answer: r["answer"], q_lang: r["q_lang"], a_lang: r["a_lang"]}})
    end
    return result
  end
end
