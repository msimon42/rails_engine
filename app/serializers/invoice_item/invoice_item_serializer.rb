class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :invoice_id, :item_id, :quantity, :unit_price 
end
