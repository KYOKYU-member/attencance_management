class UsersController < ApplicationController
  before_action :authenticate_company!, only: [:index ]

  def index
    @users = User.where(company_id: current_company.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :employee_number, :is_displayed, :password, :password_confirmation)
  end
end
