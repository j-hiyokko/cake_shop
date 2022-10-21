class OrderDetail < ApplicationRecord
  belongs_to :cart_item
  belongs_to :order
  enum product_status: {waiting_for_production: 0, paid_up: 1, in_production: 2, production_completed: 3}
end