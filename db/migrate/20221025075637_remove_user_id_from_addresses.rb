class RemoveUserIdFromAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_column :addresses, :user_id, :integer
  end
end
