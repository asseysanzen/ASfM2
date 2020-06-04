class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|

      t.integer :post_id
      t.integer :buying_user_id
      t.integer :selling_user_id
      t.integer :final_postage
      t.integer :final_price
      t.integer :buying_status, default:0, null:false, limit:1
      t.integer :selling_status, default:0, null:false, limit:1
      t.string :final_payment_method
      t.string :postal_code
      t.string :address

      t.timestamps
    end
  end
end
