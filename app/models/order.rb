class Order < ApplicationRecord
  has_many :order_histories
  belongs_to :customer
end
