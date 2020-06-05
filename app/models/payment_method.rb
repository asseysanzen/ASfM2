class PaymentMethod < ApplicationRecord

	enum status:{有効:true, 無効:false}

	validates :method, presence: true

end
