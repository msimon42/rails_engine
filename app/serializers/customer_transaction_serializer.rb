class CustomerTransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name

  attribute :transactions do |customer|
    customer.transactions
  end
end
