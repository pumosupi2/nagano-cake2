class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @cart_items = current_customer.cart_items.all

    if @cart_items.empty?
		 redirect_to cart_items_path, notice: 'カートは空です。'
    end
  end

  def confirm
    @goke = 0
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    
   if params[:order][:address_number] == "1"
    @order.postal_code = current_customer.post_code
    @order.address = current_customer.address

    @order.name = current_customer.full_name
    
   elsif params[:order][:address_number] == "2"
     address = Address.find(params[:order][:delivery_address_id]) #2でとってきたアドレス探してきた　オーダーテーブルの中のdelivery_address_idを指定してる
     @order.postal_code = address.delivery_post_code
     @order.address = address.delivery_address
     @order.name = address.delivery_address_name
     
   else 
     
   end
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
