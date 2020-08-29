FactoryBot.define do

  factory :category do
    name                  {"Tシャツ/カットソー(半袖/袖なし)"}
    trait :invalid do
      name                  {""}
    end
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end

end