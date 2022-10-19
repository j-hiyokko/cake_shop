class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details,dependent: :destroy
  belongs_to :customer
  has_one_attached :image


  def full_adresses
    self.addresses = "#{current_customer.postcode} #{current_customer.address}"
  end

  enum order_status: {
     "入金待ち":0,
     "入金確認":1,
     "製作中":2,
     "発送準備中":3,
     "発送済み":4
  }
  enum payment: ["クレジットカード", "銀行振込"]
end