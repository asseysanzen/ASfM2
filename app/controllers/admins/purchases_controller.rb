class Admins::PurchasesController < ApplicationController

	before_action :authenticate_admin!

	def top
	end

	def data
	end

	def index
		@purchases = Purchase.where.not(buying_status: "カート").order(id: "DESC")
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def update
		@purchase = Purchase.find(params[:id])
		if @purchase.update(purchase_params)

			if @purchase.selling_status == "入金確認"
				@purchase.update_attributes(buying_status: "到着待ち")
			end

			redirect_back(fallback_location: root_path)
		else
			render :show
		end
	end

	private

	def purchase_params
		params.require(:purchase).permit(:post_id, :shipping_address_id, :buying_user_id, :selling_user_id, :final_postage, :final_price, :final_payment_method, :postal_code, :address, :buying_status, :selling_status)
	end

end
