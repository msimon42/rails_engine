class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.top_n_by_revenue(n)
    result = joins(:invoice_items, :transactions)
          .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
          .group(:id)
          .merge(Transaction.successful)
          .order('revenue desc')
          .limit(n)
  end

  def favorite_customer
    customer = Customer.select('customers.*, count(transactions.id) AS total_successful_transactions')
      .joins(:merchants, :transactions)
      .merge(Transaction.successful)
      .where('invoices.merchant_id = ?', self.id)
      .group('customers.id')
      .order('total_successful_transactions DESC')
      .limit(1)

    customer.first
  end
end
