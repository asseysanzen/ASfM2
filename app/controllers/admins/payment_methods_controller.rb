class Admins::PaymentMethodsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@payment_methods = PaymentMethod.all
		@payment_method_new = PaymentMethod.new
		@postages = Postage.all
		@postage_new = Postage.new
	end

	def create
		@payment_method_new = PaymentMethod.new(payment_method_params)
		if @payment_method_new.save
			redirect_to admins_payment_methods_path
		else
			@payment_methods = PaymentMethod.all
			@postages = Postage.all
			@postage_new = Postage.new
			render :index
		end
	end

	def edit
		@payment_method = PaymentMethod.find(params[:id])
	end

	def update
		@payment_method = PaymentMethod.find(params[:id])
		if @payment_method.update(payment_method_params)
			redirect_to admins_payment_methods_path
		else
			render :edit
		end
	end

	private

	def payment_method_params
		params.require(:payment_method).permit(:method, :status)
	end

end
