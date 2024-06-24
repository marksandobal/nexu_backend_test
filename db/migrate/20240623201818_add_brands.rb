class AddBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.decimal :average_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
