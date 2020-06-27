class Admins::UsersController < ApplicationController

	before_action :authenticate_admin!

	def index
		@users = User.all.ordering.table_paginate(params) #ordering、table_paginate(params)はモデルに定義
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: params[:id]).ordering.post_paginate(params)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@posts = Post.where(user: @user).where.not(status: "売切")
		if @user.update(user_params) #ユーザーが退会した場合、販売ステータスが「売切」以外の投稿のステータスを「退会済」に更新する
			if @user.status == "退会済"
				@posts.update_all(status: "退会済")
			end
			redirect_to admins_user_path(@user.id)
		else
			render :edit
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :user_image, :profile, :twitter_account, :instagram_account, :postal_code, :address, :email, :status)
	end

end
