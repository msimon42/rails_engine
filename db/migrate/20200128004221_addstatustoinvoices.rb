class Addstatustoinvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :status, :string
  end
end
