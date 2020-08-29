class Shippingcost < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    {id: 0, name: '選択してください'},
    {id: 1, name: '送料込み(出品者負担)'},
    {id: 2, name: '着払い(購入者負担)'}
]

has_many :items
end
