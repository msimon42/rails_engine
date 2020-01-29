class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def revenue
    invoice_items.sum('unit_price * quantity')
  end

  def self.top_n_by_revenue(n)
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
          .joins(:invoice_items)
          .group(:id)
          .order('revenue DESC')
          .limit(n)
  end
end
