class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false,foreign_key: true
      t.integer :category_id, null: false,foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.string :stats, null: false
      t.string :delivery_charge, null: false
      t.string :delivery_origin_area, null: false
      t.string :days_until_delivery, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
