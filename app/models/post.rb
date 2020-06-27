class Post < ApplicationRecord

	include Paginate

	belongs_to :user
	belongs_to :genre

	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :purchases

	enum status:{販売中:0, 販売停止:1, 売切:2, 退会済:3}

	attachment :image

	validates :item_name, presence: true
	validates :description, presence: true
	validates :price, presence: true
	validates :image, presence: true

	scope :ordering, -> { order(id: "DESC") } #降順に並べる
	scope :active_posts, -> { where.not(status: "販売停止").where.not(status: "退会済") } #ユーザーが見ることができるステータスの投稿

	def favorited_by?(user) #投稿にログイン中ユーザーがいいねしているかどうか
        favorites.where(user_id: user.id).exists?
    end

    def self.search(search, user_or_post) #検索フォーム。説明文で曖昧検索
    	if user_or_post == "2" or user_or_post == "4"
        	Post.where(['description LIKE ?', "%#{search}%"])
    	else
        	Post.all
    	end
  	end

end
