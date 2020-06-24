class Users::PurchasesController < ApplicationController

	before_action :authenticate_user!

	def buy
		@purchases = Purchase.where(buying_user_id: current_user.id).active_purchase.ordering.table_paginate(params) #model
	end

	def sell
		@purchases = Purchase.where(selling_user_id: current_user.id).active_purchase.ordering.table_paginate(params)
	end

	def data
		current_purchases = Purchase.current_data.active_purchase.where(selling_user: current_user)
		@genres = Genre.find(current_purchases.group(:genre_id).order('count(genre_id) desc').pluck(:genre_id))
		@purchases = Purchase.active_purchase.where(selling_user: current_user)
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def input
		@purchase = Purchase.find(params[:id])
	end

	def new_address
		@shipping_address = ShippingAddress.new
		@purchase = Purchase.find(params[:id])
	end

	def create_address
		@shipping_address = ShippingAddress.new(shipping_address_params)
		@shipping_address.user_id = current_user.id
		@purchase = Purchase.where(buying_user: current_user).ordering.limit(1)
 		if @shipping_address.save
 			redirect_to input_users_purchase_path(@purchase.ids)
 		else
 			render :new_address
 		end
	end

	def confirm
		@purchase = Purchase.find(params[:id])
    	@postage = Postage.find(1)
	end

	def create
		@purchase = Purchase.new(purchase_params)
		@purchase.buying_user_id = current_user.id
		@purchase.save
		redirect_to input_users_purchase_path(@purchase.id)
	end

	def update
	 	@purchase = Purchase.find(params[:id])
	 	if @purchase.post.status == "売切" && @purchase.buying_status == "カート"
	 		redirect_to users_post_path(@purchase.post.id)
	 	else
	 		@purchase.update(purchase_params)
	 		path = Rails.application.routes.recognize_path(request.referer)
	 		if path[:action]  == "input"
	 			redirect_to confirm_users_purchase_path(@purchase.id)
	 		elsif path[:action] == "confirm"
	 			redirect_to users_purchases_thanks_path
	 			@purchase.post.update_attributes(status: "売切")
	 		else
	 			if @purchase.buying_status == "商品到着"
	 				@purchase.update_attributes(selling_status: "取引完了")
	 			end
	 			redirect_back(fallback_location: root_path)
	 		end
	 	end
	end

	def destroy
		@purchase = Purchase.find(params[:id]) #idの箇所はURLと同じ記述
    	@purchase.destroy
    	redirect_to root_path
	end

	def thanks
	end

	private

	def purchase_params
		params.require(:purchase).permit(:post_id, :shipping_address_id, :genre_id, :buying_user_id, :selling_user_id, :final_postage, :final_price, :final_payment_method, :postal_code, :address, :buying_status, :selling_status)
	end

	def shipping_address_params
    	params.require(:shipping_address).permit(:postal_code, :address, :user_id)
  	end

end
