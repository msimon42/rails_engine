class Addresulttotransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :result, :string
  end
end
