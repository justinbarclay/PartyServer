class PartHistory < ApplicationRecord
  belongs_to :part
  belongs_to :user

  validates :change, numericality: { only_integer: true }
end
