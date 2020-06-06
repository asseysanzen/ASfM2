class Users::PostsController < ApplicationController

	def top
	end

	def about
	end

	def index
		@posts = Post.where(status: 0).order(id: "DESC") #投稿を新しい順に並べる
	end

	def show
		@post = Post.find(params[:id])
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
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to users_post_path(@post.id)
		else
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to users_users_mypage_path
	end

	def favorite
		@posts = current_user.favorite_posts
	end

	def follow
	end

	private

	def post_params
		params.require(:post).permit(:user_id, :genre_id, :item_name, :description, :price, :image, :status)
	end

end
