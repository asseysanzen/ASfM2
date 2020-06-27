class Genre < ApplicationRecord

	has_many :posts
	has_many :purchases

	enum status:{おすすめ:0, 有効:1, 無効:2}

	validates :kind, presence: true
	validates :status, presence: true

	scope :active_genre, -> { where.not(status: "無効") } #ユーザーが使用可能なジャンルを指定

end
