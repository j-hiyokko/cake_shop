class RemoveItemImageUrlFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :item_image_url, :text
  end
end
