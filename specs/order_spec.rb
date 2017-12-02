require("minitest/autorun")
require("minitest/rg")
require_relative("../order.rb")

class TestOrder < MiniTest::Test

  def test_order_has_name
    drink_order = Order.new("Budweiser", 10, "drink")
    assert_equal("Budweiser", drink_order.name)
  end

  def test_order_has_price
    food_order = Order.new("spaghetti", 5, "food")
    assert_equal(5, food_order.price)
  end

end
