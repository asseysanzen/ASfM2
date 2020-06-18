class Users::GenresController < ApplicationController

	def show
		@posts = Post.where(genre_id: params[:id]).page(params[:page]).per(12)
		@genres = Genre.where.not(status: "無効")
		@genre = Genre.find(params[:id])
	end

end
