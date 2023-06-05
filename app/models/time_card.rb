class TimeCard < ApplicationRecord

  validates :work_day, presence: true, uniqueness: { scope: :user_id, message: "は既に存在しています" }
  validates :start_time, presence: true
  validates :working_time, presence: true
  validates :break_time, presence: true
  validates :over_time, presence: true

  belongs_to :user
end
