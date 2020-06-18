class Admins::UsersController < ApplicationController

	before_action :authenticate_admin!

	def index
		@users = User.all.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: params[:id]).order(id: "DESC").page(params[:page]).per(12)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
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
