class Part < ApplicationRecord
  has_many :part_histories
  has_many :unit_parts
  has_many :units, through: :appointments
  validates :name, presence: true
  validates :count, presence: true, numericality: { only_integer: true }
  validates :room, presence: true, length: { minimum: 1 }
end
