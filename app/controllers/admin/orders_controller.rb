class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]
  
  
  
  def update
    @order.update(order_params)
    if @order.status == "confirm_payment"
     @order.order_histories.update(making_status: "waiting_manufacture")
     redirect_to admin_order_path(@order)
    else
     redirect_to admin_order_path(@order)
    end 
  end
  
  
  private
  
  def  order_params
    params.require(:order).permit(:status)
  end
  
  
  
  def set_order
    @order = Order.find(params[:id])
  end
end