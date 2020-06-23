class Users::RelationshipsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

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
    	@users = user.following_user.active_users.ordering.table_paginate(params)
  	end

  	def followed
    	user = User.find(params[:user_id])
    	@users = user.follower_user.active_users.ordering.table_paginate(params)
  	end

end
