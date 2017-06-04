class Part < ApplicationRecord
  has_many :part_histories
  has_many :unit_parts, inverse_of: :part
  has_many :units, through: :unit_parts
  accepts_nested_attributes_for :unit_parts

  validates :name, presence: true
  validates :count, presence: true, numericality: { only_integer: true }
  validates :room, presence: true, length: { minimum: 1 }

  def as_json(options = {})
    super({
            except: [:created_at, :updated_at],
            include: {
              units: {
                only: [:name]
              },
              part_histories: { except: [:updated_at]}
            }
          }.merge(options)
    )
  end
end
