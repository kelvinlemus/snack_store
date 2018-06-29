class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.string :description
      t.decimal :sale_price, default: 0.0
      t.integer :stock_quantity, default: 0
      t.integer :likes_count, default: 0
      t.timestamps
    end
  end
end
