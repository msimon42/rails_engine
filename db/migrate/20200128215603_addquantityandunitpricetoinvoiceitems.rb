class Addquantityandunitpricetoinvoiceitems < ActiveRecord::Migration[5.1]
  def change
    add_column :invoice_items, :quantity, :integer
    add_column :invoice_items, :unit_price, :integer
  end
end
