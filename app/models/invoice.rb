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

    result.to_f / 100  
  end
end
