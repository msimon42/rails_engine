require 'rails_helper'

RSpec.describe 'invoice_items api' do
  describe 'index show' do
    before :each do
      @invoice_items = create_list :invoice_item, 10
    end

    it 'can get all invoice_items' do
      get "/api/v1/invoice_items"

      expect(response).to be_successful
      invoice_items = JSON.parse(response.body)

      expect(@invoice_items.length).to eq(10)
    end

    it 'can get an individual' do
      get "/api/v1/invoice_items/#{@invoice_items[0].id}"
      expect(response).to be_successful
      invoice_item = JSON.parse(response.body)

      expect(invoice_item['data']['attributes']['quantity']).to eq(@invoice_items[0].quantity)
      expect(invoice_item['data']['id']).to eq(@invoice_items[0].id.to_s)
    end
  end

  describe 'relationships' do
    before :each do
      @invoice = create :invoice
      @item = create :item
      @invoice_item = create :invoice_item, invoice: @invoice, item: @item
    end

    it 'can get invoice' do
      get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@invoice.id)
    end

    it 'can get items' do
      get "/api/v1/invoice_items/#{@invoice_item.id}/item"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@item.id)
    end
  end

  it 'can find_by' do
    invoice_item = create :invoice_item, unit_price: 30230

    get "/api/v1/invoice_items/find?unit_price=30230"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(invoice_item.id.to_s)
  end

  it 'can find all' do
    item = create :item
    invoiceitem_1 = create :invoice_item, item: item
    invoiceitem_2 = create :invoice_item, item: item
    invoiceitem_3 = create :invoice_item, item: item
    invoiceitem_4 = create :invoice_item

    get "/api/v1/invoice_items/find_all?item_id=#{item.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data'].length).to eq(3)
  end
end
