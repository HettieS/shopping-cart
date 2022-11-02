# frozen_string_literal: true

class ShoppingCart
  attr_accessor :items_array

  def initialize(items_array: [])
    @items_array = items_array
  end

  def scan(item)
    items_array << item
  end
end