class Shippingday < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    {id: 0, name: '選択してください'},
    {id: 1, name: '1~2日で発送'},
    {id: 2, name: '2~3日で発送'},
    {id: 3, name: '4~7日で発送'}
]

has_many :items
end
