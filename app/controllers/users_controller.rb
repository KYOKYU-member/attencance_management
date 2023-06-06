class UsersController < ApplicationController
  before_action :authenticate_company!, only: %i[index show hidden]

  def index
    @users = User.where(company_id: current_company.id)
  end

  def show
    @user = User.find(params[:id])

    # ログインユーザーの当日のタイムカード情報取得無かったら新規作成
    if @user.time_cards.find_by(work_day: Date.today).present?
      @time_card = @user.time_cards.find_by(work_day: Date.today)
    else
      @time_card = TimeCard.new
    end

    # 当月のカレンダー作成
    if params[:date].present?
      @display_month = params[:date].to_date
    else
      @display_month = Date.today
    end
    @start_date = @display_month.beginning_of_month
    @end_date = @display_month.end_of_month

    # 当月の勤務実績取得
    @work_records = {}
    (@start_date..@end_date).each do |day|
      if @user.time_cards.find_by(work_day: day).present?
        @work_records.store(day, @user.time_cards.find_by(work_day: day))
      else
        @work_records.store(day, nil)
      end
    end
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
