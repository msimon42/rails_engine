require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'methods' do
    it 'top_n_by_revenue' do
      merchants = create_list :merchant, 3

      invoice_1 = create :invoice, merchant: merchants[0]
      invoice_2 = create :invoice, merchant: merchants[0]
      invoice_3 = create :invoice, merchant: merchants[1]
      invoice_4 = create :invoice, merchant: merchants[1]
      invoice_5 = create :invoice, merchant: merchants[2]
      invoice_6 = create :invoice, merchant: merchants[2]

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

      expect(Merchant.top_n_by_revenue(2).length).to eq(2)
      expect(Merchant.top_n_by_revenue(2).first).to eq(merchants[2])
      expect(Merchant.top_n_by_revenue(2).last).to eq(merchants[1])
    end

    it 'favorite_customer' do
      merchant = create :merchant
      customers = create_list :customer, 10
      invoices_1 = create_list :invoice, 3, customer: customers[0], merchant: merchant
      invoices_2 = create_list :invoice, 2, customer: customers[1], merchant: merchant

      invoices_1.each do |invoice|
        create :transaction, invoice: invoice
      end

      invoices_2.each do |invoice|
        create :transaction, invoice: invoice
      end

      expect(merchant.favorite_customer).to eq(customers[0])
    end
  end
end
