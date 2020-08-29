class Shippingmethod < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    {id: 0, name: '選択してください'},
    {id: 1, name: 
    'らくらくFURIMA便(補償,集荷,匿名配送)
    (ネコポス[全国一律]¥195)
    (宅急便コンパクト[専用ボックス70円][全国一律]¥380)
    (宅急便[全国一律]¥700~)'},
    {id: 2, name: 'ゆうゆうFURIMA便(補償,郵便局/コンビニ受け取り,匿名配送)
    (ゆうパケット[全国一律]¥175)
    (ゆうパケットプラス[専用ボックス65円][全国一律]¥375)
    (ゆうパック[全国一律]¥700~)'},
    {id: 3, name: '大型らくらくFURIMA便(家電,家具など)
    ※ガラス製のテーブルや楽器など壊れやすいものはお受けできかねます'},
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
