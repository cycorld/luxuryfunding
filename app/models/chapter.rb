class Chapter < ActiveRecord::Base
  belongs_to :book
  has_one :user, through: :book
  has_many :cards
end
