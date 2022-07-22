class Admin::OrderHistoriesController < ApplicationController
  
  def index
    @order_histories = OrderHistory.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
end
