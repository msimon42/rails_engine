class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.rank_by_merchant(id)
    select('customers.*, count(transactions.id) AS total_successful_transactions')
      .joins(:transactions)
      .merge(Transaction.successful)
      .where('invoices.merchant_id = ?', id)
      .group(:id)
      .order('total_successful_transactions DESC')
      .limit(1)
  end

  def favorite_merchant
    merchant = Merchant.select('merchants.*, count(transactions.id) AS total_successful_transactions')
      .joins(:customers, :transactions)
      .where('invoices.customer_id = ?', self.id)
      .group('merchants.id')
      .order('total_successful_transactions DESC')
      .limit(1)

    merchant.first  
  end
end
