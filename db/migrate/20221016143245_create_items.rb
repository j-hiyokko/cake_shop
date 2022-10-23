class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id    , null: false
      t.string :item_name    , null: false
      t.integer :price       , null: false
      t.text :introduction   , null: false
      t.integer :item_status , null: false

      t.timestamps
    end
  end
end
