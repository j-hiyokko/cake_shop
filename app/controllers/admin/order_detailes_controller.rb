class Admin::OrderDetailesController < ApplicationController
  before_action :authenticate_admin!

  def update
   @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      if @order.order_details.any?{|order_detail| order_detail.product_status == "in_production"}
        @order.update(order_status: 2)
      end
      if @order.order_details.all?{|order_detail| order_detail.product_status == "production_completed"}
        @order.update(order_status:3)
      end
      redirect_to request.referer
    else
      render admin_order_path
    end
  end

  def index
    @order_detail = Customer.find(params[:customer_id])
    @order_details = @order_detail.orders.page(params[:page])
  end



  private

  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
