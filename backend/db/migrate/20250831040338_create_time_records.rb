class CreateTimeRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :time_records do |t|
      t.references :work_day, null: false, foreign_key: true, index: { unique: true }
      t.datetime :clock_in_time, null: false
      t.datetime :clock_out_time
      t.integer :break_time,null: false, default: 0

      t.timestamps
    end
  end
end
