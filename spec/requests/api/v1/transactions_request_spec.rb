require 'rails_helper'

RSpec.describe 'transactions api' do
  before :each do
    @transactions = create_list :transaction, 10
  end

  it 'can get all transactions' do
    get "/api/v1/transactions"

    expect(response).to be_successful
    transactions = JSON.parse(response.body)
    expect(transactions['data'].length).to eq(10)
  end

  it 'can get an individual' do
    get "/api/v1/transactions/#{@transactions[0].id}"
    expect(response).to be_successful
    transaction = JSON.parse(response.body)

    expect(transaction['data']['attributes']['credit_card_number']).to eq(@transactions[0].credit_card_number)
    expect(transaction['data']['id']).to eq(@transactions[0].id.to_s)
  end

  it 'can find_by' do
    transaction = create :transaction, credit_card_number: '1829493918374983'

    get "/api/v1/transactions/find?credit_card_number=1829493918374983"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data']['id']).to eq(transaction.id.to_s)
  end

  it 'can find all' do
    transaction_1 = create :transaction, credit_card_number: '1829493918374983'
    transaction_2 = create :transaction, credit_card_number: '1829493918374983'
    transaction_3 = create :transaction, credit_card_number: '1829493918374983'
    transaction_4 = create :transaction, credit_card_number: '1829534345664456'

    get "/api/v1/transactions/find_all?credit_card_number=1829493918374983"
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data['data'].length).to eq(3)
  end
end
