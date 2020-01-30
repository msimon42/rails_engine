class CustomerInvoicesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name

  attribute :invoices do |customer|
    customer.invoices
  end   
end
