FactoryBot.define do
  factory :invoice_item do
    invoice { association :invoice }
    item { association :item }
  end
end
