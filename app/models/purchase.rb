class Purchase < ApplicationRecord

	belongs_to :post
	belongs_to :shipping_address

end
