class CreateEmployments < ActiveRecord::Migration[7.2]
  def change
    create_table :employments do |t|
      t.references :store, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date
      t.integer :hourly_wage_cents, null: false, default: 0

      t.timestamps
    end

    add_index :employments, [:store_id, :user_id, :end_date]
  end
end
