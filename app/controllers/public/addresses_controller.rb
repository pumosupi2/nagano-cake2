class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def show

  end

  def  create
    @address = Address.new(addrss_params)
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :index
    end
  end

  def update

  end

  def destroy

  end
  private

  def addrss_params
    params.permit(:delivery_post_code, :delivery_address, :delivery_address_name, :customer_id)
  end

end
