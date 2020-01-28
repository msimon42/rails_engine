class Removeresult < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :result
  end
end
