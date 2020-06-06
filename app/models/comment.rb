class Comment < ApplicationRecord

	belongs_to :user
 	belongs_to :post

  	validates :post_comment, presence: true

end
