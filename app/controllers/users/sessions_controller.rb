# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: %i[create]

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

  protected

  def reject_user
    @user = User.find_by(employee_number: params[:user][:employee_number])
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == true))
        alert[:error] = "ログインできません。"
      end
    else
      alert[:error] = "社員ID・パスワードを入力してください。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
