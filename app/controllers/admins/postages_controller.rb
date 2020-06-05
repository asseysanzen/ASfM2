class Admins::PostagesController < ApplicationController

	before_action :authenticate_admin!

	def edit
		@postage = Postage.find(params[:id])
	end

	def update
		@postage = Postage.find(params[:id])
		if @postage.update(postage_params)
			redirect_to admins_payment_methods_path
		else
			render :edit
		end
	end

	def create
		@postage_new = Postage.new(postage_params)
		@postage_new.save
		redirect_to admins_payment_methods_path
	end

	private

	def postage_params
		params.require(:postage).permit(:fee)
	end

end
