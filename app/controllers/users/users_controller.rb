class Users::UsersController < ApplicationController

	def index
		@users = User.where(status: true)
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where(user_id: params[:id]).where.not(status: 1)
	end

	def mypage
		@user = current_user
		@posts = @user.posts
	end

	def fix
		@user = current_user
	end

	def fix_update
		@user = current_user
		if @user.update(user_params)
			redirect_to users_users_mypage_path
		else
			render :fix
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :user_image, :twitter_account, :instagram_account, :email, :status)
	end

end
