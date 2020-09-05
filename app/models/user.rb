class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true, length: {maximum: 20}
  # ↓正規表現で@とドメインを必須にする(複雑そうなので後回し)
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 7},format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i, message: "は英字と数字両方を含むパスワードを設定してください" } # 英字と数字の両方を含む7文字以上128文字以下

  validates :family_name, :first_name, presence: true, length: { maximum: 35 }, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々]|[a-zA-Z]|[ｧ-ﾝﾞﾟ]|[ａ-ｚＡ-Ｚ])+\z/i } # 全角ひらがな、全角カタカナ、漢字、半角英字、半角カタカナ、全角英字
 
  validates :family_name_kana, :first_name_kana, presence: true, length: { maximum: 35 }, format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/ } # カタカナのみ
  validates :birth_year, :birth_month, :birth_day, presence: true


  has_one :shipping_info, dependent: :destroy
  # has_many :todo_lists, ependent: :destroy
  # has_one :creditcard, dependent: :destroy
  # has_many :comments, dependent: :destroy
  # has_many :favorites, dependent: :destroy
  # has_many :evaluations, dependent: :destroy
  has_many :seller_items, foreign_key: :seller_id, dependent: :destroy
  has_many :buyer_items, foreign_key: :buyer_id, dependent: :destroy
  #理由はまだわからないのですが、dependent: :destroyをつけないとアソシエーションは組めなかったです
end
