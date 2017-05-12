# Class to track the transactions on a Part

class CreatePartHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :part_histories do |t|
      t.references :user, foreign_key: true
      t.integer :change
      t.references :part, foreign_key: true

      t.timestamps
    end
  end
end
