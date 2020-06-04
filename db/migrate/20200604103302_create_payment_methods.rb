class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|

      t.string :method
      t.boolean :valid, default:true

      t.timestamps
    end
  end
end
