class CreateTimeCards < ActiveRecord::Migration[7.0]
  def change
    create_table :time_cards do |t|
      t.date :employees_workday, null:false, default: -> { "NOW()" }
      t.time :punch_in, null:false, default: -> { "NOW()" }
      t.date :leaving_work_day, null:false
      t.boolean :finished_work, null:false, default:false
      t.time :leaving_work_time, null:false
      t.time :punch_out, null:false
      t.time :break_time, null:false
      t.time :over_time, null:false
      t.text :remarks, null:false, default: ""

      t.timestamps
    end
  end
end
