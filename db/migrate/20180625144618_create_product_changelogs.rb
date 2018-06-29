class CreateProductChangelogs < ActiveRecord::Migration[5.2]
  def change
    create_table :product_changelogs do |t|
      t.integer :product_id, index: true
      t.integer :user_id
      t.string :attribute_name, index: true
      t.string :old_value
      t.string :new_value
      t.timestamps

      t.index [:product_id, :attribute_name]
    end
  end
end
