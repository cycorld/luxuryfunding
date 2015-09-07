class Memory < ActiveRecord::Base
  belongs_to :user
  belongs_to :box
  belongs_to :card
end
