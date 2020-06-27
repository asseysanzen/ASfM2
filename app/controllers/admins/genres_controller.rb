class Admins::GenresController < ApplicationController

	before_action :authenticate_admin!

	def index
		@genres = Genre.all
		@genre_new = Genre.new
	end

	def show
		@posts = Post.where(genre_id: params[:id]).ordering.post_paginate(params) #ordering、post_paginate(params)はモデルに定義
		@genres = Genre.all
		@genre = Genre.find(params[:id])
	end

	def create
		@genre_new = Genre.new(genre_params)
		if @genre_new.save
			redirect_to admins_genres_path
		else
			@genres = Genre.all
			render :index
		end
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		if @genre.update(genre_params)
			redirect_to admins_genres_path
		else
			render :edit
		end
	end

	private

	def genre_params
		params.require(:genre).permit(:kind, :status)
	end

end
