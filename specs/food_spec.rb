require("minitest/autorun")
require("minitest/rg")
require_relative("../food.rb")

class TestFood < MiniTest::Test

  def setup
    @food_order = Food.new("spaghetti", 5, "pasta")
  end

  def test_food_has_name
    assert_equal("spaghetti", @food_order.name)
  end

  def test_food_has_price
    assert_equal(5, @food_order.price)
  end

end
