class Address < ApplicationRecord
  belongs_to :customer

  # validates :address_name, format: { with:/\A[ぁ-んァ-ン一-龥]/ }
  # validates :address, uniqueness: true
  validates :postcode, format: {with: /\A\d{7}\z/}, numericality: { only_integer: true }
  
  def full_addresses
    self.postcode + self.address + self.address_name
  end
  
end
