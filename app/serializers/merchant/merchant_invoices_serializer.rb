class MerchantInvoicesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :invoices do |merchant|
    merchant.invoices
  end
end
