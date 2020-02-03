class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  def self.revenue_by_date(date)
    result = where(created_at: Time.zone.parse(date)..Time.zone.parse(date).next_day)
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .sum('quantity * unit_price')
  end

  def self.top_day_by_revenue
    result = select("DATE_TRUNC('day', invoices.created_at) AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(:transactions)
      .merge(Transaction.successful)
      .group('date')
      .order('revenue DESC')
      .order('date DESC')
      .limit(1)

    result.first.date.strftime('%F')

  end
end
