class Admins::PostsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@posts = Post.all.order(id: "DESC")
		@genres = Genre.all
	end

	def sale
		@posts = Post.where(status: "販売中").order(id: "DESC")
		@genres = Genre.all
	end

	def stop
		@posts = Post.where(status: "販売停止").order(id: "DESC")
		@genres = Genre.all
	end

	def sold_out
		@posts = Post.where(status: "売切").order(id: "DESC")
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
end
