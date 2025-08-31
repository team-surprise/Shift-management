class CreateStores < ActiveRecord::Migration[7.2]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone_number
      t.string :email

      t.timestamps
    end

    add_index :stores, :name, unique: true
  end
end
