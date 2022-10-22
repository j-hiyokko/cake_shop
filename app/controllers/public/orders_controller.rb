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
      @order.address = Address.find(params[:order][:address]).address
      @order.shipping_postcode = Destination.find(params[:order][:destination]).shipping_postcode
      @order.postcode = Address.find(params[:order][:address]).postcode
      @order.address_name = Address.find(params[:order][:address]).address_name
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
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new #初期化宣言
      @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
      @order_detail.order_quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
      @order_detail.total_amount = cart_item.quantity.to_i*cart_item.item.price.to_i
      @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
      @order_detail.save #注文商品を保存
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_order_path
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