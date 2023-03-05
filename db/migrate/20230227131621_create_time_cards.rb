class CreateTimeCards < ActiveRecord::Migration[7.0]
  def change
    create_table :time_cards do |t|
      t.date :work_day, null:false, default: -> { "NOW()" }
      t.datetime :start_time, null: false, default: -> { "NOW()" }
      t.datetime :end_time
      t.integer :working_time, null: false, default: 0
      t.integer :break_time, null: false
      t.integer :over_time, null: false, default: 0
      t.text :remarks, null: false, default: ""

      t.timestamps
    end
  end
end
