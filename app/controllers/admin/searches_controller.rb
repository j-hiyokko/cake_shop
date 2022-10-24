class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]
    if @range == "商品"
      @items = Item.looks(params[:search], params[:word])
    else
      @customers = Customer.looks(params[:search], params[:word])
    end
    @word = params[:word]
  end
end
