# frozen_string_literal: true

require './lib/shopping_cart'
require './lib/shop_item'

RSpec.describe ShoppingCart do
  context 'scanning items' do
    first_item ||= ShopItem.new(product_code: "FR1", name: "Fruit tea", price: 3.11)
    cart ||= ShoppingCart.new

    it 'scans the item' do
      expect(cart.scan(first_item)).to include(first_item)
    end

    it 'updates the shopping cart' do
      expect(cart.items_array).to include(first_item)
    end

    context 'multiple items' do
      second_item ||= ShopItem.new(product_code: "SR1", name: "Strawberries", price: 5.00)

      it 'scans multiple items correctly' do
        expect(cart.scan(second_item)).to include(second_item)
      end

      it 'updates shopping cart' do
        expect(cart.items_array).to include(first_item, second_item)
      end
    end
  end
end
