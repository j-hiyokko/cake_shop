class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @orders = current_customer.order_detailes
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end
  
  def confirm
    @orders = current_customer.orders
    @order_detailes = current_customer.order_detailes
    @order.postage = 800
    @sum = @order_detailes.sum{order_detailes.item.price * order_detailes.quantiy.to_i}
    @order.billing_amount = @sum + @order.postage
    @order = Order.new(order_params)
    if params[:selected_address] == "radio1"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postcode
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:selected_address] == "radio2"
      @order.address = Address.find(params[:order][:address_for_order])
    else
      @order.address = Order.new
      @order.save
    end
  end
  
  def complete
  end
  def index
    @orders = Order.where(customer_id: current_customer.id)
  end
  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment,:postcode,:address,:address_name,:customer_id,:billing_amount,:order_status,:postage,:image)
  end
end