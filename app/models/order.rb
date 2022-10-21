class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details,dependent: :destroy
  belongs_to :customer

  validates :postcode, presence: true
  validates :address, presence: true
  validates :address_name, presence: true
  validates :payment, presence: true



  enum payment:{ credit_card: 0,transfer: 1}


  enum order_status:{ waiting_for_payment:0,payment_confirmation:1,under_construction:2,shipping_preparation:3,sent:4}



  def add_tax
    (item.price * 1.08).round
  end

end