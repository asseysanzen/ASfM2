class Users::GenresController < ApplicationController

	def show
		@posts = Post.where(genre_id: params[:id]).active_posts.ordering.post_paginate(params)
		@genres = Genre.active_genre
		@genre = Genre.find(params[:id])
	end

end
