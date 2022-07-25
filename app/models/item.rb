class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_histories, dependent: :destroy
  belongs_to :genre
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-iamge.jpg', content_type: 'image/.jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  ##消費税を求めるメソッド
  def with_tax_price
      (price * 1.1).floor
  end
end
