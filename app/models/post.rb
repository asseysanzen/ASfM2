class Post < ApplicationRecord

	belongs_to :user
	belongs_to :genre

	enum status:{販売中:0, 販売停止:1, 売切:2}

	attachment :image

end
