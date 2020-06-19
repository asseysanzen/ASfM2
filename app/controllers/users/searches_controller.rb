class Users::SearchesController < ApplicationController

	def search
		@genres = Genre.where.not(status: "無効")
		@user_or_post = params[:option]
		if @user_or_post == "1"
			@users = User.where(status: "有効").search(params[:search], @user_or_post).order(id: "DESC").page(params[:page]).per(10)
		else
			@posts = Post.where.not(status: "販売停止").where.not(status: "退会済").search(params[:search], @user_or_post).order(id: "DESC").page(params[:page]).per(12)
		end
	end

end
