class Users::ShippingAddressesController < ApplicationController

	before_action :authenticate_user!

	def index
 		@shipping_addresses = ShippingAddress.where(user_id: current_user.id)
 		@shipping_address_new = ShippingAddress.new
	end

	def create
 		@shipping_address_new = ShippingAddress.new(shipping_address_params)
 		@shipping_address_new.user_id = current_user.id
  		if @shipping_address_new.save
    		redirect_to users_shipping_addresses_path
  		else
  			@shipping_addresses = ShippingAddress.where(user_id: current_user.id)
  			render :index
  		end
	end

	def edit
		@shipping_address = ShippingAddress.find(params[:id])
	end

	def update
 		@shipping_address = ShippingAddress.find(params[:id])
 		@shipping_address.update(shipping_address_params)
  		if @shipping_address.save
    		redirect_to users_shipping_addresses_path
  		else
  			@shipping_addresses = ShippingAddress.where(user_id: current_user.id)
  			render :edit
  		end
	end

	def destroy
		@shipping_address = ShippingAddress.find(params[:id])
 		@shipping_address.destroy
 		redirect_to users_shipping_addresses_path
	end

	private

 	def shipping_address_params
  		params.require(:shipping_address).permit(:user_id, :postal_code, :address)
 	end

end
