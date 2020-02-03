require 'rails_helper'

RSpec.describe 'items api' do
  describe 'index show' do
    before :each do
      @items = create_list :item, 10
    end

    it 'can get all items' do
      get '/api/v1/items'

      expect(response).to be_successful
      items = JSON.parse(response.body)

      expect(items['data'].length).to eq(10)
    end

    it 'can get an invividual item' do
      get "/api/v1/items/#{@items[0].id}"

      expect(response).to be_successful
      item = JSON.parse(response.body)

      expect(item['data']['attributes']['description']).to eq(@items[0].description)
      expect(item['data']['id']).to eq(@items[0].id.to_s)
    end
  end

  describe 'find' do
    it 'can find_by' do
      item = create :item, name: 'widget123'

      get "/api/v1/items/find?name=widget123"
      expect(response).to be_successful
      data = JSON.parse(response.body)
      expect(data['data']['id']).to eq(item.id.to_s)
    end

    it 'can find all' do
      item_1 = create :item, unit_price: 5000
      item_2 = create :item, unit_price: 5000
      item_3 = create :item, unit_price: 5000
      item_4 = create :item, unit_price: 3452

      get "/api/v1/items/find_all?unit_price=5000"
      expect(response).to be_successful
      data = JSON.parse(response.body)
      expect(data['data'].length).to eq(3)
    end


  end

  describe 'relationships' do
    it 'can get merchant' do
      merchant = create :merchant
      item = create :item, merchant: merchant

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['id']).to eq(merchant.id.to_s)
    end

    it 'can get invoice_items' do
      it 'can get merchant' do
        item = create :item
        create_list :invoice_item, 5

        get "/api/v1/items/#{item.id}/invoice_items"

        expect(response).to be_successful
        data = JSON.parse(response.body)

        expect(data['data'].length).to eq(5)
    end
  end

  it 'can get top items by revenue' do
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

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_successful
    top_items = JSON.parse(response.body)

    expect(top_items['data'].length).to eq(2)
    expect(top_items['data'][0]['id']).to eq(items[0].id.to_s)
    expect(top_items['data'][1]['id']).to eq(items[1].id.to_s)
  end
end
