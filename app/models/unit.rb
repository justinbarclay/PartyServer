class Unit < ApplicationRecord
  has_many :unit_parts
  has_many :parts, through: :unit_parts
  
  validates :name, presence: true
end
