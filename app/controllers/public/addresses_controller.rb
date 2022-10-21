class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = '情報が追加されました'
      redirect_to action: :index
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = '情報が変更されました'
      redirect_to action: :index
    else
      @address = Address.find(params[:id])
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    @address = current_customer.addresses
    flash[:notice] = '情報が削除されました'
    redirect_to action: :index
  end

  private

  def address_params
    params.require(:address).permit(:postcode,:address,:address_name)
  end

end
