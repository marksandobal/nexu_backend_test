class AddModels < ActiveRecord::Migration[7.1]
  def change
    create_table :models do |t|
      t.string :name
      t.decimal :average_price, precision: 10, scale: 2
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
