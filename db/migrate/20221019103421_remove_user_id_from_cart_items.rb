class RemoveUserIdFromCartItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :cart_items, :user_id, :integer
  end
end
