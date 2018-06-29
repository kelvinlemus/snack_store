class CreateSaleItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_items do |t|
      t.integer :sale_id, index: true
      t.integer :product_id
      t.integer :quantity
      t.decimal :total
      t.timestamps
    end
  end
end
