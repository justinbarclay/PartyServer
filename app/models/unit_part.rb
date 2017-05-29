class UnitPart < ApplicationRecord
  belongs_to :unit
  belongs_to :part

  accepts_nested_attributes_for :unit

  validates_presence_of :unit
  validates_presence_of :part
end
