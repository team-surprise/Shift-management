class CreateWorkDays < ActiveRecord::Migration[7.2]
  def change
    create_table :work_days do |t|
      t.references :store, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :work_date, null: false
      t.integer :work_hours, null: false, default: 0

      t.timestamps
    end

    add_index :work_days, [:store_id, :user_id, :work_date], unique: true
  end
end
