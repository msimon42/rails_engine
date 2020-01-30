FactoryBot.define do
  factory :transaction do
    invoice { association :invoice }
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Date.forward(days: 500) }
    result { 'success' }
  end
end
