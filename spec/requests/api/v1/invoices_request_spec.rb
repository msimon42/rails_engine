require 'rails_helper'

RSpec.describe 'invoices api' do
  describe 'index show' do
    before :each do
      @invoices = create_list :invoice, 10
    end

    it 'can get all invoices' do
      get "/api/v1/invoices"

      expect(response).to be_successful
      invoices = JSON.parse(response.body)

      expect(@invoices.length).to eq(10)
    end

    it 'can get an individual' do
      get "/api/v1/invoices/#{@invoices[0].id}"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)

      expect(invoice['data']['attributes']['status']).to eq(@invoices[0].status)
      expect(invoice['data']['id']).to eq(@invoices[0].id.to_s)
    end
  end
  describe 'relationships' do
    before :each do
      @customer = create :customer
      @merchant = create :merchant
      @items = create_list :item, 5, merchant: @merchant
      @invoice = create :invoice, customer: @customer, merchant: @merchant

      @items.each do |item|
        @invoice_items = create_list :invoice_item, 1, invoice: @invoice, item: item
      end

      @transactions = create_list :transaction, 3, invoice: @invoice
    end

    it 'can get customer' do
      get "/api/v1/invoices/#{@invoice.id}/customer"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['id']).to eq(@customer.id.to_s)
    end

    it 'can get merchant' do
      get "/api/v1/invoices/#{@invoice.id}/merchant"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['id']).to eq(@merchant.id.to_s)
    end

    it 'can get invoice items' do
      get "/api/v1/invoices/#{@invoice.id}/invoice_items"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data'].length).to eq(5)
    end

    it 'can get transactions' do
      get "/api/v1/invoices/#{@invoice.id}/transactions"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data'].length).to eq(3)
    end

    it 'can get items' do
      get "/api/v1/invoices/#{@invoice.id}/items"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data'].length).to eq(5)
    end
  end

  it 'can find_by' do
    merchant = create :merchant
    invoice = create :invoice, merchant: merchant

    get "/api/v1/invoices/find?merchant_id=#{merchant.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(invoice.id.to_s)
  end

  it 'can find all' do
    merchant = create :merchant
    invoice_1 = create :invoice, merchant: merchant
    invoice_2 = create :invoice, merchant: merchant
    invoice_3 = create :invoice, merchant: merchant
    invoice_3 = create :invoice

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data'].length).to eq(3)
  end
end
