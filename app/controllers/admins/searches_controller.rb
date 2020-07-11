class Admins::SearchesController < ApplicationController

	before_action :authenticate_admin!

	def search
		@genres = Genre.all
		@user_or_post = params[:case] #フォームから受け取る値
		@status = params[:option] #フォームから受け取る値
		# if @user_or_post == "3" && @status == "1" #ユーザーか投稿か、ステータスはどうなっているかで場合分け
		# 	@users = User.search(params[:search], @user_or_post).ordering.table_paginate(params)
		# elsif @user_or_post == "3" && @status == "2"
		# 	@users = User.where(status: "有効").search(params[:search], @user_or_post).ordering.table_paginate(params)
		# elsif @user_or_post == "3" && @status == "3"
		# 	@users = User.where(status: "退会済").search(params[:search], @user_or_post).ordering.table_paginate(params)
		# elsif @user_or_post == "4" && @status == "4"
		# 	@posts = Post.search(params[:search], @user_or_post).ordering.post_paginate(params)
		# elsif @user_or_post == "4" && @status == "5"
		# 	@posts = Post.where(status: "販売中").search(params[:search], @user_or_post).post_paginate(params)
		# elsif @user_or_post == "4" && @status == "6"
		# 	@posts = Post.where(status: "販売停止").search(params[:search], @user_or_post).post_paginate(params)
		# elsif @user_or_post == "4" && @status == "7"
		# 	@posts = Post.where(status: "売切").search(params[:search], @user_or_post).post_paginate(params)
		# elsif @user_or_post == "4" && @status == "8"
		# 	@posts = Post.where(status: "退会済").search(params[:search], @user_or_post).ordering.post_paginate(params)
		# end
		if @user_or_post == "3"
			if @status == "1"
				@users = User.search(params[:search], @user_or_post).ordering.table_paginate(params)
			elsif @status == "2"
				@users = User.where(status: "有効").search(params[:search], @user_or_post).ordering.table_paginate(params)
			else
				@users = User.where(status: "退会済").search(params[:search], @user_or_post).ordering.table_paginate(params)
			end
		else
			if @status == "4"
				@posts = Post.search(params[:search], @user_or_post).ordering.post_paginate(params)
			elsif @status == "5"
				@posts = Post.where(status: "販売中").search(params[:search], @user_or_post).post_paginate(params)
			elsif @status == "6"
				@posts = Post.where(status: "販売停止").search(params[:search], @user_or_post).post_paginate(params)
			elsif @status == "7"
				@posts = Post.where(status: "売切").search(params[:search], @user_or_post).post_paginate(params)
			else
				@posts = Post.where(status: "退会済").search(params[:search], @user_or_post).post_paginate(params)
			end
		end
	end

end

