class Card < ActiveRecord::Base
  belongs_to :chapter
  has_many :memories
end
