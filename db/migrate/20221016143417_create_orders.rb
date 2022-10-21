class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.string :address_name   , null: false
      t.string :postcode       , null: false
      t.string :address        , null: false
      t.integer :postage       , null: false
      t.integer :billing_amount, null: false
      t.integer :payment        , null: false
      t.integer :order_status  , null: false, default: 1

      t.timestamps
    end
  end
end
