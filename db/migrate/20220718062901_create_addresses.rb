class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :customer_id, null: false
      t.string :delivery_address_name, null: false
      t.string :delivery_post_code, null: false
      t.string :delivery_address, null: false

      t.timestamps
    end
  end
end
