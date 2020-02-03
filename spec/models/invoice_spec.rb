require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:transactions)}
  end

  describe 'methods' do
    it 'revenue_by_date' do
      merchants = create_list :merchant, 3

      invoice_1 = create :invoice, merchant: merchants[0], created_at: Time.parse('2020-02-01')
      invoice_2 = create :invoice, merchant: merchants[0], created_at: Time.parse('2020-02-01')
      invoice_3 = create :invoice, merchant: merchants[1], created_at: Time.parse('2020-02-01')
      invoice_4 = create :invoice, merchant: merchants[1], created_at: Time.parse('2020-02-01')
      invoice_5 = create :invoice, merchant: merchants[2], created_at: Time.parse('2019-12-14')
      invoice_6 = create :invoice, merchant: merchants[2], created_at: Time.parse('2019-12-14')

      create :invoice_item, invoice: invoice_1, quantity: 2, unit_price: 300
      create :invoice_item, invoice: invoice_2, quantity: 3, unit_price: 500
      create :invoice_item, invoice: invoice_2, quantity: 1, unit_price: 25
      create :invoice_item, invoice: invoice_3, quantity: 6, unit_price: 10000
      create :invoice_item, invoice: invoice_4, quantity: 8, unit_price: 15000
      create :invoice_item, invoice: invoice_6, quantity: 10, unit_price: 300000
      create :invoice_item, invoice: invoice_5, quantity: 2, unit_price: 30000

      create :transaction, invoice: invoice_1
      create :transaction, invoice: invoice_2
      create :transaction, invoice: invoice_3
      create :transaction, invoice: invoice_4
      create :transaction, invoice: invoice_5
      create :transaction, invoice: invoice_6

      expect(Invoice.revenue_by_date('2020-02-01')).to eq(1821.25)
    end
  end
end
