class ShippingAddress < ApplicationRecord

	has_many :purchases

	belongs_to :user

	validates :postal_code, :address, presence: true

	def full_address #郵便番号と住所を合わせて表示（購入情報入力画面で使用）
    	postal_code.insert(3, '-') + " " + address
  	end

end
