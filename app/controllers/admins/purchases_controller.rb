class Admins::PurchasesController < ApplicationController

	before_action :authenticate_admin!

	def top
		current_purchases = Purchase.current_data.active_purchase #current_data、active_purchaseはモデルに定義
		@genres = Genre.find(current_purchases.group(:genre_id).order('count(genre_id) desc').pluck(:genre_id)) #ジャンルを売れ数が多い順に並べる
		@purchases = Purchase.active_purchase
		@today = Purchase.active_purchase.where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) #当日の売上データのみを探してくる
		@histories = [] #配列で4週間分の売上を1日分ずつ探してくる
		1.upto(27) do |i|
		  @histories << Purchase.active_purchase.where(created_at: DateTime.now.beginning_of_day - i.day..DateTime.now.end_of_day - i.day)
		end
	end

	def index
		@purchases = Purchase.active_purchase.ordering.table_paginate(params) #ordering、table_paginate(params)はモデルに定義
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def update
		@purchase = Purchase.find(params[:id])
		if @purchase.update(purchase_params) #販売ステータスが「入金確認」に更新されたら自動で購入ステータスを「到着待ち」にする
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
