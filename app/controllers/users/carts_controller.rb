class Users::CartsController < ApplicationController

	before_action :authenticate_user!

	def create
		@cart = Cart.new(cart_params)
		@cart.user_id = current_user.id
		@cart.save
		redirect_to input_users_purchases_path
	end

	def destroy
		@cart = Cart.find(params[:id])
    	@cart.destroy
    	redirect_back(fallback_location: root_path)
	end

	def destroy_all
    	@carts = current_user.carts
    	@carts.destroy_all
    	redirect_back(fallback_location: root_path)
  	end

	private

	def cart_params
		params.require(:cart).permit(:user_id, :post_id)
	end

end
