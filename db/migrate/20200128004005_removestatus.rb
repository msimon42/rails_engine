class Removestatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :status
  end
end
