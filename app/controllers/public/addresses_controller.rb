class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
    @address.customer_id = current_customer.id
  end

  def  create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      render :index
    end
  end

  def edit
   @address = Address.find(params[:id])
  end

  def update
   @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
  address = Address.find(params[:id])
  address.destroy
  redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:delivery_post_code, :delivery_address, :delivery_address_name)
  end

end
