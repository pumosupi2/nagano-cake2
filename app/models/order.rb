class Order < ApplicationRecord
  has_many :order_histories
  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  enum status: {
    wait_payment: 0,
    confirm_payment: 1,
    making: 2,
    preparing_ship: 3,
    finish_prepare: 4,
  }
  
  def total_amount
    order_histories.inject(0){ |total, order_history| total + order_history.amount }
  end
  
  def full_name
    self.last_name + " " + self.first_name
  end
end
