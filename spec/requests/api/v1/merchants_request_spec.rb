require 'rails_helper'

RSpec.describe 'merchants api' do
  it 'can get all merchants' do
    create_list :merchant, 5

    get '/api/v1/merchant'
    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants['data'].length).to eq(5)
  end

  it 'can get an individual merchant' do
    merchant = create :merchant

    get "/api/v1/merchant/#{merchant.id}"
    expect(response).to be_successful
    data = JSON.parse(response.body)

    expect(data['data']['id']).to eq(merchant.id.to_s)
    expect(data['data']['attributes']['name']).to eq(merchant.name)
  end
end
