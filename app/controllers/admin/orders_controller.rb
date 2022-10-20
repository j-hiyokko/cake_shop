class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end


  def show
    @customer = Customer.find(customer.id)
    @orders = Order.all
    @order = Order.find(params[:id])
  end
end
