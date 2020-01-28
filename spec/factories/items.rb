FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.department }
    unit_price { rand(1000..500000) }
    merchant { association :merchant }
  end
end
