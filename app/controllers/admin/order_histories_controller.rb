class Admin::OrderHistoriesController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    order_history = OrderHistory.find(params[:id])
    order_history.update(order_history_params)
    order_histories = OrderHistory.where(order_id: order_history.order_id)
    if order_history.making_status == "manufacturing"
      order_history.order.update(status: "making")
      redirect_to admin_order_path(order_history.order)
    elsif order_histories.all?{ |order_history| order_history.making_status == "finish"}
      order_history.order.update(status: "preparing_ship")
      redirect_to admin_order_path(order_history.order)
    else
      redirect_to admin_order_path(order_history.order)
    end
  end
  
  private
  
  def order_history_params
    params.require(:order_history).permit(:making_status)
  end
end
