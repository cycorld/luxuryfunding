class Book < ActiveRecord::Base
  has_many :chapters
  has_many :cards, through: :chapters
  has_many :memories, through: :chards
end
