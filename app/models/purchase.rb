class Purchase < ApplicationRecord

	include Paginate

	belongs_to :post
	belongs_to :shipping_address
	belongs_to :genre
	belongs_to :buying_user, class_name: "User"
  	belongs_to :selling_user, class_name: "User"

	enum buying_status:{カート:0, 取引成立:1, 到着待ち:2, 商品到着:3}
	enum selling_status:{入金待ち:0, 入金確認:1, 配送済:2, 取引完了:4}

	scope :ordering, -> { order(id: "DESC") } #降順で並べる
	scope :active_purchase, -> { where.not(buying_status: "カート") } #取引が成立したもの
	scope :current_data, -> { where(:created_at => 4.weeks.ago..Time.now) } #4週間前までのデータ
	scope :past_data, -> { where(:created_at => 8.weeks.ago..4.weeks.ago) } #4週間前から8週間前までのデータ

end
