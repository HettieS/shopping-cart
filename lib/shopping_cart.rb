# frozen_string_literal: true

class ShoppingCart
  attr_accessor :item_list

  def initialize(item_list: [])
    @item_list = item_list
  end

  def scan(item)
    item_list << item
  end

  def calculate_cost
    return "Your cart is empty" if item_list.empty?

    price_array = []

    item_list.map do |item|
      price_array << item.price
    end

    price_array.compact.sum
  end
end
