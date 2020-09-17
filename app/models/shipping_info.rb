class ShippingInfo < ApplicationRecord
  belongs_to :user, optional: true

  validates :family_name, :first_name, :postcode, :prefecture, :city, :house_number, :family_name_kana, :first_name_kana, presence: true
  validates :family_name_kana, :first_name_kana, format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/ }, allow_blank: true # カタカナのみ
end
