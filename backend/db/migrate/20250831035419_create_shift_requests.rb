class CreateShiftRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :shift_requests do |t|
      t.references :store, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :requested_date_user
      t.datetime :requested_date_store

      t.timestamps
    end

    add_index :shift_requests, [:store_id, :user_id]
  end
end
