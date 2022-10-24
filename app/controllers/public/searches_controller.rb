class Public::SearchesController < ApplicationController
  def search
    @items = Item.looks(params[:search], params[:word])
    @word = params[:word]
  end
end
