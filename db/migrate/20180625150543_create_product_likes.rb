class CreateProductLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_likes do |t|
      t.integer :product_id, index: true
      t.integer :user_id
      t.timestamps
    end
  end
end
