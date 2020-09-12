class Item < ApplicationRecord
  has_many :item_imgs, dependent: :destroy
  accepts_nested_attributes_for :item_imgs, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shippingarea
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :itemcondition
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shippingcost
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shippingday
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shippingmethod
  #has_many :comments, dependent: :destroy
  #has_many :favorites, dependent: :destroy
  #has_many :evaluations
  belongs_to :category
  #belong_to_active_hash :item_size
  belongs_to :seller, foreign_key: :seller_id, class_name: "User"
  #class_name: "User"の部分、クラス、テーブル名はrailsの場合大文字から始めるのが原則
  belongs_to :buyer, foreign_key: :buyer_id, class_name: "User", optional: true
  #belongs_toは必ず値が入らなければいけない。この場合buyer_idは出品の時はnilであるので、optional: trueをつけることによって、nilでもいいよ！という風にする
  enum dealing:{sell:0,sold:1,shipped:2,transit:3,delivery:4,delivered:5}
  #sell=出品中、sold=売却済み、shipped=発送済み、transit=輸送中、delivery=配達中、delivered=到着済み
  #参考画像:https://www.mercari.com/jp/help_center/article/132/
  validates :name, presence: true, length: { maximum: 40 }
  validates :item_explanation, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  #validates :dealing, presence: true#取引状況は後。商品出品タスクの項目に入ってないので。
  validates :shippingarea, presence: true
  validates :category_id, presence: true
  validates :itemcondition_id, presence: true
  validates :shippingmethod_id, presence: true
  validates :shippingcost_id, presence: true
  validates :shippingday_id, presence: true
  validates :item_imgs, presence: true
  validates :seller_id, presence: true
end
