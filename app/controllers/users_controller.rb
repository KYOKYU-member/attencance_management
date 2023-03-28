class UsersController < ApplicationController
  before_action :authenticate_company!, only: %i[index show hidden]

  def index
    @users = User.where(company_id: current_company.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def hidden
    @user = User.find(params[:id])
    @user.update(is_displayed: false)
    redirect_to users_path, notice: "ユーザーを非表示にしました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :employee_number, :is_displayed, :password, :password_confirmation)
  end
end
