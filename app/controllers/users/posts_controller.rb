class Users::PostsController < ApplicationController

	def top
	end

	def about
	end

	def index
	end

	def show
	end

	def new
		@post_new = Post.new
	end

	def create
		@post_new = Post.new(post_params)
		if @post_new.save
			redirect_to users_users_mypage_path
		else
			render :new
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def favorite
	end

	def follow
	end

	private

	def post_params
		params.require(:post).permit(:user_id, :genre_id, :item_name, :description, :price, :image, :status)
	end

end
