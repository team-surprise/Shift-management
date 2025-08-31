class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :full_name, :string, null: false, default: ""
    add_column :users, :phone_number, :string
  end

  add_index :users, :full_name, unique: true
end
