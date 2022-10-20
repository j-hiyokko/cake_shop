class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details,dependent: :destroy
  belongs_to :customer

  validates :postcode, presence: true
  validates :address, presence: true
  validates :address_name, presence: true
  validates :payment, presence: true

  enum payment: { credit_card: 0, transfer: 1}

  enum order_status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}

  enum payment: { クレジットカード: 0, 銀行振込: 1 }

  def add_tax
    (item.price * 1.08).round
  end

end