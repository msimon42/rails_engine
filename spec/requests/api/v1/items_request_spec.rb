require 'rails_helper'

RSpec.describe 'items api' do
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

  it 'can find_by' do
    item = create :item, name: 'widget123'

    get "/api/v1/items/find?name=widget123"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(item.id.to_s)
  end
end
