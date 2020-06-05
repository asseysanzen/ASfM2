class Genre < ApplicationRecord

	has_many :posts

	enum status:{おすすめ:0, 有効:1, 無効:2}

	validates :kind, presence: true
	validates :status, presence: true

end
