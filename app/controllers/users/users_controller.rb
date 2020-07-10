class Users::UsersController < ApplicationController

	before_action :active_user, only: [:show] #退会したユーザーの詳細画面を見れなくするため
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_user, only: [:mypage, :fix, :withdrawal, :fix_update]

	def index
		@users = User.active_users.ordering.table_paginate(params) #active_users、ordering、table_paginate(params)はモデルに定義
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: params[:id]).where.not(status: "販売停止").ordering.post_paginate(params)
	end

	def mypage
		@posts = Post.where(user_id: current_user.id).ordering.post_paginate(params)
	end

	def fix
	end

	def withdrawal
	end

	def fix_update
		@posts = Post.where(user: @user).where.not(status: "売切")
		if @user.update(user_params)
			if @user.status == "退会済"
				@posts.update_all(status: "退会済") #退会したユーザーの投稿は販売ステータスが「売切」のもの以外「退会済」に変更する
				reset_session
				flash[:notice] = "退会手続きが完了しました。"
				redirect_to root_path
			else
				redirect_to users_users_mypage_path
			end
		else
			render :fix
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :user_image, :twitter_account, :instagram_account, :email, :status, :profile)
	end

	def active_user #URL直打ち防止
		@user = User.find(params[:id])
		if @user.status == "退会済"
			redirect_to users_users_path
		end
	end

	def set_user
		@user = current_user
	end

end
