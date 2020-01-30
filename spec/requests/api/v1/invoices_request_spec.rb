require 'rails_helper'

RSpec.describe 'invoices api' do
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

  it 'can find_by' do
    merchant = create :merchant
    invoice = create :invoice, merchant: merchant

    get "/api/v1/invoices/find?merchant_id=#{merchant.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(invoice.id.to_s)
  end
end
