# frozen_string_literal: true

class ShoppingCart
  attr_accessor :item_list, :offer_items

  def initialize(item_list: [], offer_items: [])
    @item_list = item_list
    @offer_items = offer_items
  end

  def scan(item)
    item_list << item
  end

  def calculate_cost
    return 'Your cart is empty' if item_list.empty?

    price_array = []

    items =  apply_fruit_tea_offer? ? update_item_list : item_list

    items.map do |item|
      price_array << item.price
    end

    price_array.compact.sum.round(2)
  end

  def fruit_teas
    fruit_teas = []

    item_list.map do |item|
      if item.product_code.include?("FR1")
        fruit_teas << item
      end
    end

    fruit_teas
  end

  def apply_fruit_tea_offer?
    fruit_teas.count.positive?
  end

  def update_item_list
    fruit_tea = offer_items.select { |item| item.product_code == "FR1" }

    item_list << fruit_tea.first if fruit_teas.count.odd?

    item_list.each do |item|
      divide_price_by_two(item)
    end

    item_list
  end

  def divide_price_by_two(item)
    if item.product_code.include?("FR1")
      item.price = item.price / 2
    end
  end
end
