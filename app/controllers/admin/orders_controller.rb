class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]

  
  def show
    
  end

  def update
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :show
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
