require 'takeaway'

RSpec.describe Takeaway do
  let(:test_takeaway) { Takeaway.new(test_menu, test_message_client) }
  let(:test_menu) { double(:menu, dishes: [{ dish: item_1, available: 1 }, 
                                           { dish: item_2, available: 2 },
                                           { dish: item_3, available: 4 },
                                           { dish: item_4, available: 1 }]) 
  }
  let(:item_1) { double(:pizza, name: :pepperoni_pizza, price: 8) }
  let(:item_2) { double(:pizza, name: :margherita_pizza, price: 6) }
  let(:item_3) { double(:pizza, name: :vegetarian_pizza, price: 6) }
  let(:item_4) { double(:pizza, name: :sausage_pizza, price: 8.5) }
  let(:test_message_client) { double(:message_client, send_message: true, confirm_order: 'message sent') }
  it 'has a menu' do
    expect(test_takeaway.view_menu).to eq "Item 1: Pepperoni Pizza – £8\nItem 2: Margherita Pizza – £6\nItem 3: Vegetarian Pizza – £6\nItem 4: Sausage Pizza – £8.5"
  end

  it 'can take an order for a pepperoni pizza and a margherita pizza' do
    test_takeaway.add_to_order(item_1)
    test_takeaway.add_to_order(item_2)

    expect(test_takeaway.view_current_order).to eq [:pepperoni_pizza, :margherita_pizza]
  end

  it 'can take an order for a vegetarian pizza and a margherita pizza' do
    test_takeaway.add_to_order(item_3)
    test_takeaway.add_to_order(item_2)

    expect(test_takeaway.view_current_order).to eq [:vegetarian_pizza, :margherita_pizza]
  end

  it 'denies an order when a dish is out of stock' do
    test_takeaway.add_to_order(item_4)

    expect { test_takeaway.add_to_order(item_4) }.to raise_error Takeaway::OUT_OF_STOCK
  end

  it 'begins a new order once an order has been successfully placed' do
    test_takeaway.add_to_order(item_1)
    test_takeaway.add_to_order(item_2)
    test_takeaway.place_order
    test_takeaway.add_to_order(item_3)
    test_takeaway.add_to_order(item_4)

    expect(test_takeaway.view_current_order).to eq [:vegetarian_pizza, :sausage_pizza]
  end
end
