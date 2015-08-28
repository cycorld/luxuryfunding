class Box < ActiveRecord::Base
  belongs_to :user
  has_many :cards

  def import file
    CSV.foreach(file, {headers: true}) do |r|
      Card.create(box_id: id, question: r["question"], answer: r["answer"])
    end
  end
end
