class Unit < ApplicationRecord
  has_many :unit_parts
  has_many :units, through: :unit_parts
  validates :name
end
