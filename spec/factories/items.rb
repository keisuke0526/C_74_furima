FactoryBot.define do

  factory :item do
    name                  {"商品名テスト"}
    price                 {"1000"}
    item_explanation      {"testテスト商品説明"}
    category_id           {"3"}
    brand                 {"brandテスト"}
    shippingarea_id       {"1"}#発送元地域
    shippingcost_id       {"1"}#発送時の費用負担
    itemcondition_id      {"1"}#商品状態
    shippingmethod_id     {"1"}#発送方法
    shippingday_id        {"1"}#発送までの日時
    trait :invalid do
      name                  {""}
    end
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end

end