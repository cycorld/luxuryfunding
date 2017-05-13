class Card < ActiveRecord::Base
  has_one :user, through: :chapter
  belongs_to :chapter
  has_many :memories
end
