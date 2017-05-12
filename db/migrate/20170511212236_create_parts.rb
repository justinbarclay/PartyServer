# Adding parts to database
class CreateParts < ActiveRecord::Migration[5.0]
  def change
    create_table :parts do |t|
      t.string   :name
      t.integer  :count
      t.string   :room
      t.string   :shelf
      t.timestamps
    end
  end
end
