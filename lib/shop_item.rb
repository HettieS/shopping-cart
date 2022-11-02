# frozen_string_literal: true

class ShopItem
  attr_reader :product_code, :name, :price

  def initialize(product_code: nil, name: nil, price: nil)
    @product_code = product_code
    @name = name
    @price = price
  end
end
