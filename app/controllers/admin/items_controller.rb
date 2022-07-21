class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @item = Item.new
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit

  end

  def update

  end
  
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
  end

end
