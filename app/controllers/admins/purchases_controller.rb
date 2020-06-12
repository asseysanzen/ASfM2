class Admins::PurchasesController < ApplicationController

	before_action :authenticate_admin!

	def top
		current_purchases = Purchase.where(:created_at => 4.weeks.ago..Time.now).where.not(buying_status: "カート")
		genre_sales_counts = current_purchases.group(:genre_id).count
		genre_sales_ids = Hash[genre_sales_counts.sort_by{ |_, v| -v }].keys
		@genres = Genre.where(id: genre_sales_ids)
		@purchases = Purchase.where.not(buying_status: "カート")
		@today = Purchase.where.not(buying_status: "カート").where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day)
		#@day_1 = Purchase.where.not(buying_status: "カート").where(created_at: DateTime.now.beginning_of_day - 1.day..DateTime.now.end_of_day - 1.day)
		i = 1
		while i <= 27 do
			@day_i = Purchase.where.not(buying_status: "カート").where(created_at: DateTime.now.beginning_of_day - i.day..DateTime.now.end_of_day - i.day)
			i += 1
		end
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
