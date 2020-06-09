class Users::PurchasesController < ApplicationController

	before_action :authenticate_user!

	def buy
	end

	def sell
	end

	def show
	end

	def input
		@purchase = Purchase.find(params[:id])
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
	 	@purchase.update(purchase_params)
	 	path = Rails.application.routes.recognize_path(request.referer)
	 	if path[:action]  == "input"
	 		redirect_to confirm_users_purchase_path(@purchase.id)
	 	else
	 		redirect_to users_purchases_thanks_path
	 	end
	end

	def destroy
		@purchase = Purchase.find(params[:id]) #idの箇所はURLと同じ記述
    	@cart_product.destroy
    	redirect_to root_path
	end

	def thanks
	end

	private

	def purchase_params
		params.require(:purchase).permit(:post_id, :shipping_address_id, :buying_user_id, :selling_user_id, :final_postage, :final_price, :final_payment_method, :postal_code, :address, :buying_status)
	end

	# def shipping_address_params
 #    	params.require(:shipping_address).permit(:postal_code, :address)
 #  	end

end
