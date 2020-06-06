class ShippingAddress < ApplicationRecord

	belongs_to :user

	validates :postal_code, :address, presence: true

end
