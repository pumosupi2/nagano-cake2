class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @goke = 0
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.postal_code = current_customer.post_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end
  
  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart|
        order_history = OrderHistory.new
        order_history.item_id = cart.item_id
        order_history.order_id = @order.id
        order_history.amount = cart.amount
        order_history.price = cart.item.price
        order_history.save
    end
    redirect_to orders_complete_path
    @cart_items.destroy_all
    else
    @order = Order.new(order_params)
    render :new
    end
  end

  def complete
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :customer_id, :payment_method, :shipping_cost, :total_payment, :status)
  end
end
