class AddBarcodeAndValueToParts < ActiveRecord::Migration[5.0]
  def change
    add_column :parts, :barcode, :string, default: ''
    add_column :parts, :value, :float, default: 0
  end
end
