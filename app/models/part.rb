class Part < ApplicationRecord
  has_many :part_histories

  validates :name, presence: true
  validates :count, presence: true, numericality: { only_integer: true }
  validates :room, presence: true, length: { minimum: 1 }
end
