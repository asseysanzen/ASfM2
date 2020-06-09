class ShippingAddress < ApplicationRecord

	has_many :purchases

	belongs_to :user

	validates :postal_code, :address, presence: true

	def full_address
    	postal_code + " " + address
  	end

end
