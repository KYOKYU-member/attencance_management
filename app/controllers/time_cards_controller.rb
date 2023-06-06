class TimeCardsController < ApplicationController
  before_action :authenticate_user!, unless: :current_company
  before_action :set_user, only: %i[new starting_work index edit destroy]
  before_action :set_time_card_user, only: %i[create update]
  before_action :set_time_card, only: %i[leaving_work edit update destroy]
  require 'date'

  def index
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

  def new
    @time_card = TimeCard.new
  end

  def create
    # newで入力された文字列をTimezoneに変換
    work_day = Time.zone.parse(params[:time_card][:work_day])
    start_time = Time.zone.parse(params[:time_card][:work_day] + " " + params[:time_card][:start_time])
    end_time = Time.zone.parse(params[:time_card][:work_day] + " " + params[:time_card][:end_time])
    work_minutes = start_time.present? ? (end_time - start_time).floor / 60 : 0

    # start_timeとend_timeからその他時間を計算して保存
    @time_card = @user.time_cards.build
    @time_card.work_day = work_day
    @time_card.start_time = start_time
    @time_card.end_time = end_time
    @time_card.break_time = 60
    @time_card.working_time = work_minutes - @time_card.break_time > 0 ? work_minutes - @time_card.break_time : 0
    @time_card.over_time = work_minutes - 540 > 0 ? work_minutes - 540 : 0
    @time_card.remarks = params[:time_card][:remarks]
    if @time_card.save
      redirect_to root_path, notice: "タイムカードを作成しました" if user_signed_in?
      redirect_to user_path(@user), notice: "タイムカードを作成しました" if company_signed_in?
    else
      render :new, status: :unprocessable_entity
    end
  end

  def starting_work 
    #出勤ボタンを押した場合の処理
    @time_card = @user.time_cards.build
    @time_card.work_day = Date.today
    @time_card.start_time = Time.current
    @time_card.break_time = 60
    if @time_card.save
      redirect_to root_path, notice: "出勤時間を打刻しました"
    else
      render :index
    end
  end

  def leaving_work
    # 退勤ボタンを押した場合の処理
    work_minutes = (Time.current - @time_card.start_time).floor / 60
    if @time_card.update(
      end_time: Time.current,
      working_time: work_minutes - @time_card.break_time > 0 ? work_minutes - @time_card.break_time : 0,
      over_time: work_minutes - 540 > 0 ? work_minutes - 540 : 0
    )
      redirect_to root_path, notice: "退勤時間を打刻しました"
    else
      render :index
    end
  end

  def edit
  end

  def update
    start_time = Time.zone.parse(params[:time_card][:work_day] + " " + params[:time_card][:start_time])
    end_time = Time.zone.parse(params[:time_card][:work_day] + " " + params[:time_card][:end_time])
    work_minutes = start_time.present? ? (end_time - start_time).floor / 60 : 0
    if @time_card.update(
      start_time: start_time,
      end_time: end_time,
      working_time: work_minutes - @time_card.break_time > 0 ? work_minutes - @time_card.break_time : 0,
      over_time: work_minutes - 540 > 0 ? work_minutes - 540 : 0,
      remarks: params[:time_card][:remarks]
    )
      redirect_to root_path, notice: "タイムカードを更新しました" if user_signed_in?
      redirect_to user_path(@user), notice: "タイムカードを更新しました" if company_signed_in?
    else
      render :edit
    end
  end

  def destroy
    @time_card.destroy
    redirect_to root_path, notice: "出勤記録を削除しました" if user_signed_in?
    redirect_to user_path(@user), notice: "出勤記録を削除しました" if company_signed_in?
  end

  private

  def time_card_params
    params.require(:time_card).permit(:work_day, :start_time, :end_time, :working_time, :break_time, :over_time, :remarks)
  end

  def set_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    # elsif params[:time_card][:user_id].present?
    #   @user = User.find(params[:time_card][:user_id])
    else
      @user = User.find(current_user.id)
    end
  end

  def set_time_card_user
    if params[:time_card][:user_id].present?
      @user = User.find(params[:time_card][:user_id])
    else
      @user = User.find(current_user.id)
    end
  end

  def set_time_card
    @time_card = TimeCard.find(params[:id])
  end
end
