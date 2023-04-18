class CreateShiftTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :shift_types do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.integer :break_time

      t.timestamps
    end
  end
end
