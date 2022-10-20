class Item < ApplicationRecord

  belongs_to:order
  belongs_to:genre
  has_many:cart_items,dependent: :destroy

  validates :genre_id, presence: true
  validates :item_name, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
  validates :item_status, presence: true

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

  enum item_status: { available:1,unavailable:0 }

end
