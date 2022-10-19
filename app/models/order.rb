class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  
  validates :postcode, presence: true
  validates :address, presence: true 
  validates :address_name, presence: true 
  validates :payment, presence: true 
  
  
  def add_tax
    (item.price * 1.08).round
  end
  
end