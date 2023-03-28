class TimeCardsController < ApplicationController
  before_action :authenticate_user!
  require 'date'

  def new
    day = Date.today
    start_date = Date::new(day.year,day.month, 1)
    end_date = start_date >> 3
    start_date = start_date << 1

    (Date.parse("#{start_date}")..Date.parse("#{end_date}")).each do |date|
      @date = date
      @start_date = start_date
      @end_date = end_date
    end
  end
end
