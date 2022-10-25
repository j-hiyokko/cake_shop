class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "payment_confirmation"
       @order.order_details.update_all(product_status: 1)
    end
    
    redirect_to request.referer
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end


end

