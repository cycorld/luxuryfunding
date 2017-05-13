class Chapter < ActiveRecord::Base
  belongs_to :book
  has_one :user, through: :book
  has_many :cards, inverse_of: :chapter
  accepts_nested_attributes_for :cards, reject_if: :all_blank, allow_destroy: true, update_only: true
end
