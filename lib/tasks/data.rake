# require 'csv'
#
# csv_text_merchant = File.read('db/csvs/merchants.csv')
# csv = CSV.parse(csv_text_merchant, :headers => true)
# csv.each do |row|
#   Merchant.create!(row.to_hash)
# end
#
# csv_text_customer = File.read('db/csvs/customers.csv')
# csv = CSV.parse(csv_text_customer, :headers => true)
# csv.each do |row|
#   Customer.create!(row.to_hash)
# end
#
# csv_text_item = File.read('db/csvs/items.csv')
# csv = CSV.parse(csv_text_item, :headers => true)
# csv.each do |row|
#   Item.create!(row.to_hash)
# end
#
# csv_text_invoice = File.read('db/csvs/invoices.csv')
# csv = CSV.parse(csv_text_invoice, :headers => true)
# csv.each do |row|
#   Invoice.create!(row.to_hash)
# end
#
# csv_text_transaction = File.read('db/csvs/transactions.csv')
# csv = CSV.parse(csv_text_transaction, :headers => true)
# csv.each do |row|
#   Transaction.create!(row.to_hash)
# end
#
# csv_text_invoice_item = File.read('db/csvs/inovice_items.csv')
# csv = CSV.parse(csv_text_invoice_item, :headers => true)
# csv.each do |row|
#   InvoiceItem.create!(row.to_hash)
# end
