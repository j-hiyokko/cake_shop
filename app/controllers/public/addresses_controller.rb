class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to action: :index
    else
      @address = Address.new
      @addresses = Address.all
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
    flash[:success] = "登録情報を編集しました。"
      redirect_to action: :index
    else
      flash[:alert] = "もう一度入力してください。"
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to action: :index
  end

  private

  def address_params
    params.require(:address).permit(:postcode,:address,:address_name).merge(customer_id: current_customer.id)
  end

end
