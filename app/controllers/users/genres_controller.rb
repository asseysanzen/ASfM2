class Users::GenresController < ApplicationController

	def show
		@posts = Post.where(genre_id: params[:id]).active_posts.ordering.post_paginate(params) #active_posts、ordering、post_paginate(params)はモデルに定義
		@genres = Genre.active_genre #active_genreはモデルに定義
		@genre = Genre.find(params[:id])
	end

end
