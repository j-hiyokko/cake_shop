class Admin::OrderDetailesController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      if @order.order_status == "入金待ち"
        @order_details.update_all(product_status: "着手不可")
      elsif @order.orderstatus == "入金確認"
        @order_details.update_all(product_status: "製作待ち")
      end
      redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end



  private

  def order_params
    params.require(:order).permit(:product_status)
  end
end
