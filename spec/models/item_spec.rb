require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should belong_to(:merchant)}
  end

  describe 'methods' do
    it 'top_n_by_revenue' do
      items = create_list :item, 3
      invoices = create_list :invoice, 3

      create :invoice_item, item: items[0], invoice: invoices[0], quantity: 10, unit_price: 50000
      create :invoice_item, item: items[0], invoice: invoices[0], quantity: 10, unit_price: 25000
      create :invoice_item, item: items[1], invoice: invoices[1], quantity: 10, unit_price: 5000
      create :invoice_item, item: items[1], invoice: invoices[1], quantity: 10, unit_price: 2500
      create :invoice_item, item: items[2], invoice: invoices[2], quantity: 10, unit_price: 500
      create :invoice_item, item: items[2], invoice: invoices[2], quantity: 10, unit_price: 250

      invoices.each do |invoice|
        create :transaction, invoice: invoice, result: 'success'
      end

      expect(Item.top_n_by_revenue(2).length).to eq(2)
      expect(Item.top_n_by_revenue(2).first).to eq(items[0])
      expect(Item.top_n_by_revenue(2).last).to eq(items[1])
    end
  end
end
