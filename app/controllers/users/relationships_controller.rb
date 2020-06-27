class Users::RelationshipsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

	def create
        @user = User.find(params[:user_id])
        current_user.follow(params[:user_id]) #followはモデルに定義
  	end

  	def destroy
        @user = User.find(params[:user_id])
        current_user.unfollow(params[:user_id]) #unfollowはモデルに定義
  	end

  	def follower
    	user = User.find(params[:user_id])
    	@users = user.following_user.active_users.ordering.table_paginate(params) #following_user、active_users、ordering、table_paginate(params)はモデルに定義
  	end

  	def followed
    	user = User.find(params[:user_id])
    	@users = user.follower_user.active_users.ordering.table_paginate(params) #follower_userはモデルに定義
  	end

end
