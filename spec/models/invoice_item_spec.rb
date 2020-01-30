require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end

  describe 'methods' do
    before :each do
      @item = create :item
      @invoice = create :invoice
      @invoice_item = create :invoice_item, item: @item, invoice: @invoice
    end

    it 'find_and_return_parent' do
      invoice = InvoiceItem.find_and_return_parent(@invoice_item.id.to_s, 'invoice')
      expect(invoice.id).to eq(@invoice.id)
    end
  end
end
