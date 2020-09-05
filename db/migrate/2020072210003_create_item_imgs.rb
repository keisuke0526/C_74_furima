class CreateItemImgs < ActiveRecord::Migration[5.2]
  def change
    create_table :item_imgs do |t|
      t.string :image, null:false
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end
