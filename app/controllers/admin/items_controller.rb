class Admin::ItemsController < ApplicationController

  def index
    @genre = Genre.all
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @genre = Genre.all
    @item = Item.new(item_params)
    if @item.save!
      redirect_to admin_item_path(@item.id)
    else
      render:new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @genre = Genre.all
    @item = Item.find(params[:id])
  end

  def update
    @genre = Genre.all
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render:edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name,:introduction,:price,:item_image,:genre_id,:item_status)
  end

end
