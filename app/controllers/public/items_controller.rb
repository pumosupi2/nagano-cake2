class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @items_all = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

end