class OrderHistory < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  
  enum making_status: {
    impossible_manufacture: 0,
    waiting_manufacture: 1,
    manufacturing: 2,
    finish: 3,
  }
end
