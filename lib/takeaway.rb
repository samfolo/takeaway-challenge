require 'menu'
require 'order'

class Takeaway

  OUT_OF_STOCK = ''

  def initialize(menu = Menu.new, order_class = Order)
    @menu = menu
    @order_class = order_class
    @current_order = @order_class.new
  end

  def view_menu
    menu = @menu.dishes.map.with_index { |listed, i|
      "Item #{i + 1}: #{formatted(listed[:dish].name)} – £#{listed[:dish].price}"
    }
    menu.join("\n")
  end

  def add_to_order(choice)
    item = @menu.dishes.select { |existing| choice == existing[:dish] }.first
    raise OUT_OF_STOCK if item[:available].zero?

    @current_order.add_item(item)
    item[:available] -= 1
  end

  def view_order
    @current_order.items_ordered.map { |order_item| order_item[:dish].name }
  end

  private

  def formatted(symbol)
    symbol.to_s.split('_').map { |word| word.capitalize }.join(' ')
  end
end
