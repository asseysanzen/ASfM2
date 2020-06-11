class Purchase < ApplicationRecord

	belongs_to :post
	belongs_to :shipping_address
	belongs_to :genre
	belongs_to :buying_user, class_name: "User"
  	belongs_to :selling_user, class_name: "User"

	enum buying_status:{カート:0, 取引成立:1, 到着待ち:2, 商品到着:3}
	enum selling_status:{入金待ち:0, 入金確認:1, 配送済:2, 取引完了:4}

end
