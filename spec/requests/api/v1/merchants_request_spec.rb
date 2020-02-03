require 'rails_helper'

RSpec.describe 'merchants api' do
  describe 'index show' do
    it 'can get all merchants' do
      create_list :merchant, 5

      get '/api/v1/merchants'
      expect(response).to be_successful

      merchants = JSON.parse(response.body)
      expect(merchants['data'].length).to eq(5)
    end
  end

  describe 'relationships' do
    it 'can get an individual merchant' do
      merchant = create :merchant

      get "/api/v1/merchants/#{merchant.id}"
      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['id']).to eq(merchant.id.to_s)
      expect(data['data']['attributes']['name']).to eq(merchant.name)
    end

    it 'can get all items associated with merchant' do
      merchant = create :merchant
      items = create_list :item, 10, merchant: merchant

      get "/api/v1/merchants/#{merchant.id}/items"
      expect(response).to be_successful

      data = JSON.parse(response.body)
      expect(data['data'].count).to eq(10)
    end
  end

  it 'can get all invoices associated with merchant' do
    merchant = create :merchant
    invoices = create_list :invoice, 10, merchant: merchant

    get "/api/v1/merchants/#{merchant.id}/invoices"
    expect(response).to be_successful

    data = JSON.parse(response.body)
    expect(data['data'].count).to eq(10)
  end

  it 'can obtain top n merchants based on revenue' do
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

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_successful
    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data'].length).to eq(2)
    expect(top_merchants['data'].first['id'].to_i).to eq(merchants[2].id)
    expect(top_merchants['data'].last['id'].to_i).to eq(merchants[1].id)

    get "/api/v1/merchants/most_revenue?quantity=3"

    top_merchants_2 = JSON.parse(response.body)
    expect(top_merchants_2['data'].last['id'].to_i).to eq(merchants[0].id)
  end

  it 'can find_by' do
    merchant = create :merchant, name: 'matt'

    get "/api/v1/merchants/find?name=matt"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(merchant.id.to_s)
  end

  it 'can find all' do
    merchant_1 = create :merchant, name: 'WilliamsonGroup'
    merchant_2 = create :merchant, name: 'WilliamsonGroup'
    merchant_3 = create :merchant
    merchant_4 = create :merchant

    get "/api/v1/merchants/find_all?name=WilliamsonGroup"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data'].length).to eq(2)
  end

  it 'can get favorite customer by merchant' do
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

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_successful
    customer = JSON.parse(response.body)

    expect(customer['data']['id']).to eq(customers[0].id.to_s)
  end
end
