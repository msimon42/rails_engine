class MerchantItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :items do |merchant|
    merchant.items
  end
end
