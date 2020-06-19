# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_out_path_for(resource)
    root_path(resource)
  end

  def after_sign_in_path_for(resource)
    users_users_mypage_path
  end

  def reject_user
     @user = user.find_by(email: params[:user][:email].downcase)
     if @user
       if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
         flash[:notice] = "退会済みです。"
         redirect_to new_user_session_path
       end
     else
       flash[:notice] = "必須項目を入力してください。"
     end
   end

end
