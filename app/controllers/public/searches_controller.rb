class Public::SearchesController < ApplicationController
  def search
    @items = Item.looks(params[:search], params[:word])
    @genres = Genre.all
    @word = params[:word]
  end
end
