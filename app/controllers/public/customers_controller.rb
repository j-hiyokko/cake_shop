class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "登録情報を編集しました。"
      redirect_to customers_path(current_customer)
    else
      flash[:alert] = "もう一度入力してください。"
      render :edit
    end
  end

  def withdraw
    @customer = current_customer
    @customer.update(user_status: "false")
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phonenumber, :email, :user_status)
  end
end
