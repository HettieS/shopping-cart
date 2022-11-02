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
      expect(cart.item_list).to include(first_item)
    end

    context 'multiple items' do
      second_item ||= ShopItem.new(product_code: "SR1", name: "Strawberries", price: 5.00)

      it 'scans multiple items correctly' do
        expect(cart.scan(second_item)).to include(second_item)
      end

      it 'updates shopping cart' do
        expect(cart.item_list).to include(first_item, second_item)
      end
    end
  end

  context 'calculating total' do
    cart ||= ShoppingCart.new
    banana = ShopItem.new(product_code: "1B", name: "Banana", price: 1.50)
    pear = ShopItem.new(product_code: "2P", name: "Pear", price: 1.00)
    total_cost = (banana.price + pear.price)

    it 'calculates the correct total for items' do
      cart.scan(banana)
      cart.scan(pear)

      expect(cart.calculate_cost).to eq(total_cost)
    end

    context 'when the cart is empty' do
      empty_cart ||= ShoppingCart.new
      empty_cart_message = 'Your cart is empty'

      it 'returns empty string' do
        expect(empty_cart.calculate_cost).to eq(empty_cart_message)
      end
    end

    context 'fruit tea offer' do
      offer_item = ShopItem.new(product_code: "FR1", name: "Fruit tea", price: 3.11)
      cart_with_offer ||= ShoppingCart.new(offer_items: [offer_item])
      fruit_tea_one = ShopItem.new(product_code: "FR1", name: "Fruit tea", price: 3.11)
      fruit_tea_two = ShopItem.new(product_code: "FR1", name: "Fruit tea", price: 3.11)
      cost = (fruit_tea_one.price).round(2)

      context 'when the cart contains two fruit teas' do
        it 'one is deducted from the total cost' do
          cart_with_offer.scan(fruit_tea_one)
          cart_with_offer.scan(fruit_tea_two)

          expect(cart_with_offer.calculate_cost).to eq(cost)
        end
      end

      context 'when there are an odd number of fruit teas' do
        fruit_tea_three = ShopItem.new(product_code: "FR1", name: "Fruit tea", price: 3.11)

        it 'free tea is added to cart' do
          cart_with_offer.scan(fruit_tea_three)
          cart_with_offer.calculate_cost

          expect(cart_with_offer.item_list.count).to eq(4)
        end
      end
    end
  end
end
