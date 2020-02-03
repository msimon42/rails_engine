class Item < ApplicationRecord
  include ConvertToDollars
  before_validation :convert_to_dollars
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.top_n_by_revenue(n)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .joins(:invoice_items, :transactions)
        .merge(Transaction.successful)
        .group(:id)
        .order('revenue DESC')
        .limit(n)
  end

  def best_day
    invoices.top_day_by_revenue
  end
end
