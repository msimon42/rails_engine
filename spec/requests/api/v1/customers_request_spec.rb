require 'rails_helper'
RSpec.describe 'customers api' do
  before :each do
    @customers = create_list :customer, 10
  end

  it 'can get all customers' do
    get "/api/v1/customers"

    expect(response).to be_successful
    customers = JSON.parse(response.body)

    expect(@customers.length).to eq(10)
  end

  it 'can get an individual' do
    get "/api/v1/customers/#{@customers[0].id}"
    expect(response).to be_successful
    customer = JSON.parse(response.body)

    expect(customer['data']['attributes']['first_name']).to eq(@customers[0].first_name)
    expect(customer['data']['id']).to eq(@customers[0].id.to_s)
  end

  it 'can find_by' do
    customer = create :customer, first_name: 'matt'

    get "/api/v1/customers/find?first_name=matt"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(customer.id.to_s)
  end
end
