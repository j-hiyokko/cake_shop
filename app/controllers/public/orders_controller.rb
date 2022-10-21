class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @subtotal = @cart_items.inject(0){|sum,item| sum + item.subtotal }
    if params[:order][:address_option] == "0"
      @order.address = current_customer.address
      @order.postcode = current_customer.postcode
      @order.address_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
      @order.address = ship.postcode
      @order.postcode = ship.address
      @order.address_name = ship.address_name
    elsif params[:order][:address_option] == "2"
      @order.address = params[:order][:address]
      @order.postcode = params[:order][:postcode]
      @order.address_name = params[:order][:address_name]
    else
       render 'new'
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to complete_order_path@order = Order.new(order_params)
    @order.total_payment = cart_total + shipping_cost
    @order.customer_id = current_customer.id
    @order.shipping_cost = shipping_cost
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.tax_price = cart_item.cart_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end
  def index
    @orders = Order.where(customer_id: current_customer.id)
  end
  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment,:postcode,:address,:address_name,:customer_id,:billing_amount,:order_status,:postage,:image)
  end
end