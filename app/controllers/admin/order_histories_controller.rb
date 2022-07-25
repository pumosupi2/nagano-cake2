class Admin::OrderHistoriesController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order_history = OrderHistory.find(params[:id])
    if @order_history.update(order_history_params)
      redirect_to admin_order_path(@order_history.order)
    else
      render :show
    end
  end
  
  private
  
  def order_history_params
    params.require(:order_history).permit(:making_status)
  end
end
