class TimeCardsController < ApplicationController
  before_action :authenticate_user!, unless: :current_company
  require 'date'

  def new
    day = Date.today
    start_date = Date::new(day.year,day.month, 1)
    end_date = (start_date >> 1) - 1
    (start_date..end_date).each do |date|
      @date = date
      @start_date = start_date
      @end_date = end_date
    end
  end
end
