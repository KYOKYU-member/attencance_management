class UsersController < ApplicationController
  before_action :authenticate_company!, only: %i[index show hidden]

  def index
    @users = User.where(company_id: current_company.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :employee_number, :is_displayed, :password, :password_confirmation)
  end
end
