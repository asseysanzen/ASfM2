class RemaneValidColumnToPaymentMethods < ActiveRecord::Migration[5.2]
  def change
  	rename_column :payment_methods, :valid, :status
  end
end
