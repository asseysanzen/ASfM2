class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    include Paginate #定義したページングを使用するためcontrollers/concerns/paginate.rbに定義

    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

    attachment :user_image

    has_many :posts, foreign_key: :id, primary_key: :user_id, dependent: :destroy
    has_many :purchases
    has_many :shipping_addresses, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_posts, through: :favorites, source: :post
    has_many :comments, dependent: :destroy
    has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following_user, through: :follower, source: :followed
    has_many :follower_user, through: :followed, source: :follower
    has_many :buying_user, class_name: "Purchase", foreign_key: "buying_user_id", dependent: :destroy
    has_many :selling_user, class_name: "Purchase", foreign_key: "selling_user_id", dependent: :destroy

    enum status:{有効:true, 退会済:false}

    validates :name, presence: true

    scope :active_users, -> { where(status: "有効") } #有効会員
    scope :ordering, -> { order(id: "DESC") } #降順に並べる

    def active_for_authentication?
        super && (self.status == "有効")
    end

    def self.search(search, user_or_post) #検索フォーム。名前で曖昧検索
        if user_or_post == "1" or user_or_post == "3"
            User.where(['name LIKE ?', "%#{search}%"])
        else
            User.all
        end
    end

    def follow(user_id)
        follower.create(followed_id: user_id)
    end

    def unfollow(user_id)
        follower.find_by(followed_id: user_id).destroy
    end

    def following?(user)
        following_user.include?(user)
    end

end
