class Users::PurchasesController < ApplicationController

	before_action :authenticate_user!

	def buy #自分が購入した履歴のみ表示
		@purchases = Purchase.where(buying_user_id: current_user.id).active_purchase.ordering.table_paginate(params) #active_purchase、ordering、table_paginate(params)はモデルに定義
	end

	def sell #自分が販売した履歴のみ表示
		@purchases = Purchase.where(selling_user_id: current_user.id).active_purchase.ordering.table_paginate(params)
	end

	def data
		current_purchases = Purchase.current_data.active_purchase.where(selling_user: current_user) #ログインユーザーの過去4週間の売上を検索
		@genres = Genre.find(current_purchases.group(:genre_id).order('count(genre_id) desc').pluck(:genre_id)) #ログインユーザーの売数が多い順でジャンルを並べる
		@purchases = Purchase.active_purchase.where(selling_user: current_user)
	end

	def show
		@purchase = Purchase.find(params[:id])
	end

	def input
		@purchase = Purchase.find(params[:id])
	end

	def new_address #購入ボタンを押した後に配送先を登録するため
		@shipping_address = ShippingAddress.new
		@purchase = Purchase.find(params[:id])
	end

	def create_address #shipping_addressコントローラーのcreateアクションとは画面遷移先を分けるためにこのアクションを使用
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
    	@postage = Postage.find(1) #送料は1つしか登録できないようにしているためidが１のもののみ探してくる
	end

	def create
		@purchase = Purchase.new(purchase_params)
		@purchase.buying_user_id = current_user.id
		@purchase.save
		redirect_to input_users_purchase_path(@purchase.id)
	end

	def update #「購入」ボタンを押すと購入ステータスが「カート」となる。その後「購入確定」ボタンを押すと購入ステータスが「取引成立」となり購入したことになる
			   #「カート」の履歴はバッチ処理により30分に１回削除される
	 	@purchase = Purchase.find(params[:id])
	 	if @purchase.post.status == "売切" && @purchase.buying_status == "カート" #同じ商品を同時にカートに入れてしまった人がいた場合後に購入確定を押した人が買えなくるするための条件分岐
	 		redirect_to users_post_path(@purchase.post.id)
	 	else
	 		@purchase.update(purchase_params)
	 		path = Rails.application.routes.recognize_path(request.referer) #アクションにより遷移先を分ける
	 		if path[:action]  == "input"
	 			redirect_to confirm_users_purchase_path(@purchase.id)
	 		elsif path[:action] == "confirm"
	 			redirect_to users_purchases_thanks_path
	 			@purchase.post.update_attributes(status: "売切") #購入が確定したら販売ステータスを「売切」に自動的に変更する
	 		else
	 			if @purchase.buying_status == "商品到着" #購入ステータスが「商品到着」になったら自動的に販売ステータスを「取引完了」にする
	 				@purchase.update_attributes(selling_status: "取引完了")
	 			end
	 			redirect_back(fallback_location: root_path)
	 		end
	 	end
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
