class Order < ApplicationRecord
has_many :items
has_many :order_details
belongs_to :customer
end