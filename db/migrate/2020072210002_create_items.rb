class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :item_explanation, null: false
      t.integer :price, null: false
      t.integer :dealing,default: 0, null: false, limit: 1
      t.integer :shippingarea_id,null: false
      t.string :brand, null: false
      # t.bigint :category_id, null: false, foreign_key: true
      t.references :category, type: :bigint, null: false, foreign_key: true
      t.integer :shippingcost_id,null: false
      t.integer :itemcondition_id,null: false
      t.integer :shippingmethod_id,null: false
      t.integer :shippingday_id,null: false
      #t.references :item_size, null: false, foreign_key: true
      t.references :seller, foreign_key: { to_table: :users }, null: false, default: 0
      t.references :buyer, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end