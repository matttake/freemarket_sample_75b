class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_reading, null: false
      t.string :last_name_reading, null: false
      t.integer :zip_code, null: false
      t.string :prefectures, null: false
      t.string :city, null: false
      t.string :address_line1
      t.string :address_line2
      t.timestamps
    end
  end
end
