class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
    @subtotal = @cart_items.inject(0){|sum,item| sum + item.subtotal }
  end

  def create
    if cart_item = CartItem.find_by(item_id:cart_item_params[:item_id])
      # cart_item.quantity += (cart_item_params[:item_id][:quantity]).to_i
      cart_item.quantity += cart_item_params[:quantity].to_i
      cart_item.save
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
      cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id,:item_id,:quantity)
  end

end
