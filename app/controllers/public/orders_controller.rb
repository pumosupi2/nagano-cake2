class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end

  def confirm
    @goke = 0
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end
  
  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity
        order_item.order_price = cart.item.price
        order_item.save
    end
    redirect_to orders_complete_path
    cart_items.destroy_all
    else
    @order = Order.new(order_params)
    render :new
    end
  end

  def complete
    
  end

  def index
    
  end

  def show
    
  end
  
  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
