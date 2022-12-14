class Item < ApplicationRecord

  belongs_to:order,optional: true
  belongs_to:genre,optional: true
  has_many:cart_items,dependent: :destroy

  validates:item_name,:introduction,:price,:genre_id,:item_status,presence:true

  has_one_attached :item_image

  def get_item_image# (width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/NOIMAGE.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image#.variant(resize_to_limit: [width, height]).processed
  end

  def add_tax_price
    (price * 1.08).floor
  end

  def self.looks(search, word)
    where("item_name LIKE?","%#{word}%")
  end

  enum item_status: { available:1,unavailable:0 }

end
