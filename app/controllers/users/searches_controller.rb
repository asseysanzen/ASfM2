class Users::SearchesController < ApplicationController

	def search
		@genres = Genre.active_genre
		@user_or_post = params[:option] #フォームから送られてくる値を取得
		if @user_or_post == "1" #ユーザーか投稿かで条件分岐
			@users = User.active_users.search(params[:search], @user_or_post).table_paginate(params)
		else
			@posts = Post.active_posts.search(params[:search], @user_or_post).ordering.post_paginate(params)
		end
	end

end
