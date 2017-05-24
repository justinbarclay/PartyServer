class CreateUnitParts < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_parts do |t|
      t.belongs_to :part, index: true
      t.belongs_to :unit, index: true
      t.timestamps
    end
  end
end
