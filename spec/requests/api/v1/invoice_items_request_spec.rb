require 'rails_helper'

RSpec.describe 'invoice_items api' do
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

  it 'can find_by' do
    invoice_item = create :invoice_item, unit_price: 30230

    get "/api/v1/invoice_items/find?unit_price=30230"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(invoice_item.id.to_s)
  end
end
