class InvoiceItem < ApplicationRecord
  include ConvertToDollars
  before_validation :convert_to_dollars
  belongs_to :invoice
  belongs_to :item

  def self.find_and_return_parent(id, attr)
    invoice_item = find(id)
    invoice_item.send(attr)
  end
end
