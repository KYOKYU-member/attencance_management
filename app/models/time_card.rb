class TimeCard < ApplicationRecord

  validates :work_day, presence: true
  validates :start_time, presence: true
  validates :working_time, presence: true
  validates :break_time, presence: true
  validates :over_time, presence: true
end
