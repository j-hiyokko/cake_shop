class Item < ApplicationRecord
  has_one_attached :item_image

  def get_image
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/NOIMAGE.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
