FactoryBot.define do
  factory :invoice do
    customer { association :customer }
    merchant { association :merchant }
    status { 'shipped' }
  end
end
