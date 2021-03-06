class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.find_and_return_parent(id, attr)
    invoice_item = find(id)
    invoice_item.send(attr)
  end
end
