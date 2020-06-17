class Users::FavoritesController < ApplicationController

	before_action :authenticate_user!

	def create
        @post = Post.find(params[:post_id])
        @favorite = Favorite.new(post_id: @post.id)
        @favorite.user_id = current_user.id
        @favorite.save
        end

    def destroy
        @post = Post.find(params[:post_id])
        @favorite = Favorite.find_by(post_id: @post.id)
        @favorite.user_id = current_user.id
        @favorite.destroy
    end

end
