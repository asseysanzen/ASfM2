class Genre < ApplicationRecord

	has_many :posts #foreign_key: :post_id, primary_key: :post_id
	has_many :purchases

	enum status:{おすすめ:0, 有効:1, 無効:2}

	validates :kind, presence: true
	validates :status, presence: true

end
