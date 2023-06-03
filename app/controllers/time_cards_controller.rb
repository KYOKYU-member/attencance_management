class TimeCardsController < ApplicationController
  before_action :authenticate_user!, unless: :current_company
  before_action :set_user, only: %i[new create index]
  require 'date'

  # def new
  #   @start_display = true
  #   # if @user.time_cards.where(work_day: Date.today).present?
  #   #   @start_display = false
  #   # end
  #   # @time_card = TimeCard.new

  #   if @user.time_cards.where(work_day: Date.today).present?
  #     @start_display = false
  #     @time_card = @user.time_cards.where(work_day: Date.today)
  #   else
  #     @time_card = TimeCard.new
  #   end

  #   day = Date.today
  #   start_date = Date::new(day.year,day.month, 1)
  #   end_date = (start_date >> 1) - 1
  #   (start_date..end_date).each do |date|
  #     @date = date
  #     @start_date = start_date
  #     @end_date = end_date
  #   end
  # end

  def index
    if @user.time_cards.find_by(work_day: Date.today).present?
      @time_card = @user.time_cards.find_by(work_day: Date.today)
    else
      @time_card = TimeCard.new
    end

    day = Date.today
    @start_date = day.beginning_of_month
    @end_date = day.end_of_month
    @work_records = {}

    (@start_date..@end_date).each do |day|
      if @user.time_cards.find_by(work_day: day).present?
        @work_records.store(day, @user.time_cards.find_by(work_day: day))
      else
        @work_records.store(day, nil)
      end
    end
  end

  def create
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

  def update
    @time_card = TimeCard.find(params[:id])
    work_minutes = (Time.current - @time_card.start_time).floor / 60
    if @time_card.update(
      end_time: Time.current,
      working_time: work_minutes - 60,
      over_time: 580 - work_minutes > 0 ? 580 - work_minutes : 0
    )
      redirect_to root_path, notice: "退勤時間を打刻しました"
    else
      render :index
    end

  end

  private

  def time_card_params
    params.require(:time_card).permit(:work_day, :start_time, :end_time, :working_time, :break_time, :over_time, :remarks)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
