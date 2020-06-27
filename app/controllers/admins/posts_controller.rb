class Admins::PostsController < ApplicationController

	before_action :authenticate_admin!
	before_action :soldout_post, only: [:edit] #売切になったアイテムを編集できなくするため

	def index
		@posts = Post.all.ordering.post_paginate(params) #ordering、post_paginate(params)はモデルに定義
		@genres = Genre.all
	end

	def show
		@post = Post.find(params[:id])
		@genres = Genre.all
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to admins_post_path(@post.id)
		else
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to admins_posts_path
	end

	private

	def post_params
		params.require(:post).permit(:user_id, :genre_id, :item_name, :description, :price, :image, :status)
	end

	def soldout_post #売切投稿の編集画面へのURL直打ち防止
		@post = Post.find(params[:id])
		if @post.status == "売切"
			redirect_to admins_post_path(@post)
		end
	end

end
