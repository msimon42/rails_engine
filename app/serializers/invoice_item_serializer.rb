class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :item_id, :quantity

  attribute :unit_price do |item|
    (item.unit_price.to_f / 100).to_s
  end
end
