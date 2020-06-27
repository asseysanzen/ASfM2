class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_image, :twitter_account, :instagram_account])
    	#会員登録画面での項目の追加
  	end

end
