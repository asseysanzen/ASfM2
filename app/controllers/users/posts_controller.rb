class Users::PostsController < ApplicationController

	def top
		@genres = Genre.where.not(status: "無効")
		@posts = Post.joins(:user, :genre).where(posts: {status: "販売中"}).where(users: {status: "有効"}).where(genres: {status: "おすすめ"}).limit(6).order(id: "DESC").page(params[:page]).per(6)
	end

	def about
	end

	def index
		@posts = Post.joins(:user).where.not(posts: {status: "販売停止"}).where(users: {status: "有効"}).order(id: "DESC").page(params[:page]).per(12) #投稿を新しい順に並べる
		@genres = Genre.where.not(status: "無効")
	end

	def show
		@post = Post.find(params[:id])
		@purchase = Purchase.new
		@comment = Comment.new
		@genres = Genre.where.not(status: "無効")
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
		@posts = current_user.favorite_posts.order(id: "DESC").page(params[:page]).per(12)
		@genres = Genre.where.not(status: "無効")
	end

	def follow
		@user = current_user
		@users = @user.following_user
		@genres = Genre.where.not(status: "無効")
	end

	private

	def post_params
		params.require(:post).permit(:user_id, :genre_id, :item_name, :description, :price, :image, :status)
	end

end
