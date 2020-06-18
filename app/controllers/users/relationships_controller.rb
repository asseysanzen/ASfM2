class Users::RelationshipsController < ApplicationController

  before_action :authenticate_user!

	def create
        @user = current_user
        @user.follow(params[:user_id])
    	redirect_to request.referer
  	end

  	def destroy
        @user = current_user
    	@user.unfollow(params[:user_id])
    	redirect_to request.referer
  	end

  	def follower
    	user = User.find(params[:user_id])
    	@users = user.following_user.order(id: "DESC").page(params[:page]).per(10)
  	end

  	def followed
    	user = User.find(params[:user_id])
    	@users = user.follower_user.order(id: "DESC").page(params[:page]).per(10)
  	end

end
