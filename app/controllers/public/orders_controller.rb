class Public::OrdersController < ApplicationController
before_action :authenticate_customer!
  def new
    @order = Order.new
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
      ship = Address.find(params[:order][:address_id])
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
    @cart_items = current_customer.cart_items
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new #初期化宣言
        @order_detail.item_id = cart_item.item_id #商品idを注文商品idに代入
        @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
        @order_detail.order_quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
        @order_detail.total_amount = cart_item.quantity.to_i*cart_item.item.price.to_i
        @order_detail.save #注文商品を保存
      end
        current_customer.cart_items.destroy_all
        redirect_to complete_order_path
    else
      flash.now[:danger] = "※配送先を入力してください"
      render 'new'
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
    params.require(:order).permit(:payment,:postcode,:address,:address_name,:customer_id,:billing_amount,:order_status,:postage)
  end


end