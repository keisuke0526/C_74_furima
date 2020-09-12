class Shippingmethod < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    {id: 0, name: '選択してください'},
    {id: 1, name: 
    'らくらくFURIMA便'},
    {id: 2, name: 'ゆうゆうFURIMA便'},
    {id: 3, name: '大型らくらくFURIMA便(家電,家具など)'},
    {id: 4, name: 'ゆうメール'},
    {id: 5, name: 'レターパック'},
    {id: 6, name: '普通郵便(定型,定形外)'},
    {id: 7, name: 'クロネコヤマト'},
    {id: 8, name: 'ゆうパック'},
    {id: 9, name: 'クリックポスト'},
    {id: 10, name: 'ゆうパケット'},
    {id: 11, name: '未定'}
]

has_many :items
end
