class Users::GenresController < ApplicationController

	def show
		@posts = Post.where(genre_id: params[:id])
		@genres = Genre.where.not(status: "無効")
		@genre = Genre.find(params[:id])
	end

end
