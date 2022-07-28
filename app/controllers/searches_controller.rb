class SearchesController < ApplicationController
  def search
    @items = Item.where("name LIKE?", "%#{params[:word]}%")
    @genres = Genre.all
    @items_all = Item.all
    @item_page = Item.page(params[:page])
  end
end
