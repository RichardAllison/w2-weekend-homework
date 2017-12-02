require("minitest/autorun")
require("minitest/rg")
require_relative("../drinks.rb")

class TestDrink < MiniTest::Test

  def setup
    @drink_order = Drink.new("Budweiser", 10, "Beer")
  end

  def test_drink_has_name
    assert_equal("Budweiser", @drink_order.name)
  end

  def test_order_has_price
    assert_equal(10, @drink_order.price)
  end

end
