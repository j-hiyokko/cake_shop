class Public::OrdersController < ApplicationController
  def new
  end
  def confirm
  end
  def create
    @order = Order.new(book_params)
    @ordr.user_id = current_user.id
    @order.save
      redirect_to book_path(@book)
  end
  def index
    @orders = Order.where(customer_id: current_customer.id)
  end
  def show
    @order = Order.find(params[:id])
  end

end
