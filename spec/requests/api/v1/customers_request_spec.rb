require 'rails_helper'
RSpec.describe 'customers api' do
  describe 'index show' do
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
  end

  describe 'relationships' do
    before :each do
      @customer = create :customer
      @invoices = create_list :invoice, 10, customer: @customer
      create_list :invoice, 2
      @transactions = create_list :transaction, 10, invoice: @invoices[0]
      create_list :transaction, 2
    end

    it 'can get all invoices' do
      get "/api/v1/customers/#{@customer.id}/invoices"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['attributes']['invoices'].count).to eq(10)
    end

    it 'can get all transactions' do
      get "/api/v1/customers/#{@customer.id}/transactions"

      expect(response).to be_successful
      data = JSON.parse(response.body)

      expect(data['data']['attributes']['transactions'].count).to eq(10)
    end
  end

  it 'can find_by' do
    customer = create :customer, first_name: 'matt'

    get "/api/v1/customers/find?first_name=matt"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(customer.id.to_s)
  end

  it 'can find all' do
    customer_1 = create :customer, last_name: 'Gonzalez'
    customer_2 = create :customer, last_name: 'Gonzalez'
    customer_3 = create :customer, last_name: 'Gonzalez'
    customer_4 = create :customer, last_name: 'Smith'

    get "/api/v1/customers/find_all?last_name=Gonzalez"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data'].length).to eq(3)
  end
end
