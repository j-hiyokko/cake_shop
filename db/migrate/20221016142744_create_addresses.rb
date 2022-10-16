class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|

      t.integer :user_id     , null: false
      t.string :postcode     , null: false
      t.string :address      , null: false
      t.string :address_name , null: false

      t.timestamps
    end
  end
end
