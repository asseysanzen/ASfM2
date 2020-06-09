class AddShippingAddressIdToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :shipping_address_id, :integer
  end
end
