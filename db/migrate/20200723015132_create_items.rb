class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :item_explanation, null: false
      t.integer :price, null: false
      t.integer :dealing,default: 0, null: false, limit: 1
      t.integer :shippingarea_id
      t.string :brand, null: false
      t.references :category, null: false, foreign_key: true
      t.integer :shippingcost_id
      t.integer :itemcondition_id
      t.integer :shippingmethod_id
      t.integer :shippingday_id
      #t.references :item_size, null: false, foreign_key: true
      #t.references :seller, null: false, foreign_key: true
      #t.references :buyer, null: false, foreign_key: true
      t.timestamps
    end
  end
end