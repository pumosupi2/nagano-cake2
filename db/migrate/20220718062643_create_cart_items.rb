class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :item_id, null: false
      t.integer :customer_id, null: false
      t.integer :amount,numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10}

      t.timestamps
    end
  end
end
