class RenameUserIdColumnToCartitems < ActiveRecord::Migration[6.1]
  def change
    rename_column :cart_items, :user_id, :customer_id
  end
end
