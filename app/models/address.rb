class Address < ApplicationRecord
  belongs_to :customer
  
  def address_display
    '〒' + delivery_post_code + '' + delivery_address + '' + delivery_address_name
  end
  
end
