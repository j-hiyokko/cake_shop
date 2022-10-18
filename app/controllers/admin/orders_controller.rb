class Admin::OrdersController < ApplicationController
  def new
    @order = Order.new
    @orders = current_customer.cart_items
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end

  def confirm
    @orders = current_customer.orders
    @cart_items = current_customer.cart_items
    @sum = @cart_items.sum{|ci| ci.item.price * ci.amount}
    @order = Order.new(order_params)

    if params[:selected_address] == "radio1"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:selected_address] == "radio2"
      @order.address = Address.find(params[:order][:address_for_order])
    else
      @order.address = Order.new
      @order.save
    end
  def complete
  end

　def order_params
    params.require(:order).permit(:payment, :postcode, :address,:address_name,:user_id,:postage,:billing_amount,:order_status)
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :amount, :production_status, :price)
  end

end
