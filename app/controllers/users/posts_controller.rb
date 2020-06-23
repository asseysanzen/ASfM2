class Users::PostsController < ApplicationController

	before_action :active_post, only: [:show]
	before_action :authenticate_user!, except: [:top, :about, :index, :show]

	def top
		@genres = Genre.active_genre
		@posts = Post.joins(:user, :genre).where(posts: {status: "販売中"}).where(users: {status: "有効"}).where(genres: {status: "おすすめ"}).limit(6).ordering.page(params[:page]).per(6)
	end

	def about
	end

	def index
		@posts = Post.active_posts.ordering.post_paginate(params)
		@genres = Genre.active_genre
	end

	def show
		@post = Post.find(params[:id])
		@purchase = Purchase.new
		@comment = Comment.new
		@genres = Genre.active_genre
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
		@posts = current_user.favorite_posts.active_posts.ordering.post_paginate(params)
		@genres = Genre.active_genre
	end

	def follow
		@user = current_user
		@users = @user.following_user.active_users
		@genres = Genre.active_genre
	end

	private

	def post_params
		params.require(:post).permit(:user_id, :genre_id, :item_name, :description, :price, :image, :status)
	end

	def active_post
		@post = Post.find(params[:id])
		if @post.user.status == "退会済"
			redirect_to users_posts_path
		end
	end

end
