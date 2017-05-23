class CreateUnitParts < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_parts do |t|
      t.belongs_to :parts, index: true
      t.belongs_to :units, index: true
      t.timestamps
    end
  end
end
