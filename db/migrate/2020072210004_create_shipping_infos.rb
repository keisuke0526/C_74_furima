class CreateShippingInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_infos do |t|
      t.string :family_name,      null: false
      t.string :first_name,       null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana,  null: false
      t.integer :postcode,        null: false
      t.integer :prefecture,      null: false
      t.string :city,             null: false
      t.string :house_number,     null: false
      t.string :building
      t.integer :home_call_num
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
