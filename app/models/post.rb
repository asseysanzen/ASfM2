class Post < ApplicationRecord

	belongs_to :user
	belongs_to :genre

	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	enum status:{販売中:0, 販売停止:1, 売切:2}

	attachment :image

	def favorited_by?(user) #投稿にログイン中ユーザーがいいねしているかどうか
        favorites.where(user_id: user.id).exists?
    end

end
