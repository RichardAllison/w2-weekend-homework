require("minitest/autorun")
require("minitest/rg")
require_relative("../bar.rb")
require_relative("../room.rb")
require_relative("../guest.rb")
require_relative("../food.rb")
require_relative("../drinks.rb")
require_relative("../order.rb")

class TestBar < MiniTest::Test

  def setup
    @guest1 = Guest.new("Richard", 29, 10, "It won't go")
    @guest2 = Guest.new("Ivan", 32, 30, "Rockin' all over the world")
    @guest3 = Guest.new("Archie", 17, 40, "Blueberry Hill")

    @beer = Drink.new("Budweiser", 10, "beer", 5)
    @vodka = Drink.new("Smirnoff", 30, "vodka", 40)
    @wine = Drink.new("Cabarnet", 20, "wine", 15)
    @coke = Drink.new("Coca Cola", 5, "soft drink", 0)

    @pasta = Food.new("Spaghetti", 5, "pasta")
    @sushi = Food.new("Sushi", 15, "sushi")
    @side = Food.new("Chips", 2, "side")

    @big_room = Room.new("Big room", 50, 10, [])
    @small_room = Room.new("Small room", 5, 10, [])

    drinks = [@beer, @vodka, @wine, @coke]
    food = [@pasta, @side]
    @bar = Bar.new("CodeClan Caraoke Bar", drinks, food)

  end

  def test_bar_has_name
    assert_equal("CodeClan Caraoke Bar", @bar.name)
  end

  def test_bar_creates_spending_tab
    @bar.create_guest_tab(@guest1, @big_room)
    assert_equal([{name: "Richard", tab: 10}], @bar.guest_tabs)
  end

  def test_bar_creates_array_of_guest_tabs
    @bar.create_guest_tab(@guest1, @big_room)
    @bar.create_guest_tab(@guest2, @big_room)
    @bar.create_guest_tab(@guest3, @big_room)
    assert_equal([{name: "Richard", tab: 10},{name: "Ivan", tab: 10},{name: "Archie", tab: 10}], @bar.guest_tabs)
  end

  def test_find_bar_tab_by_name
    @bar.create_guest_tab(@guest1, @big_room)
    @bar.create_guest_tab(@guest2, @big_room)
    @bar.create_guest_tab(@guest3, @big_room)
    found_guest_tab = @bar.find_guest_tab_by_name("Richard")
    assert_equal({name: "Richard", tab: 10}, found_guest_tab)
  end

  def test_room_checkin_creates_bar_tab
    @big_room.checkin_guest(@bar, @guest1)
    assert_equal([{name: "Richard", tab: 10}], @bar.guest_tabs)
  end


  # testing extra food and drink functions below

  def test_can_find_drink__true
    found_drink = @bar.find_drink_by_name("Budweiser")
    assert_equal(@beer, found_drink)
  end

  def test_can_find_drink__false
    assert_nil(@bar.find_drink_by_name("Gin"))
  end

  def test_can_find_food__true
    assert_equal(@pasta, @bar.find_food_by_name("Spaghetti"))
  end

  def test_can_find_food__false
    assert_nil(@bar.find_food_by_name("Sushi"))
  end

  def test_customer_old_enough__true
    assert_equal(true, @bar.guest_old_enough?(@guest1))
  end

  def test_customer_old_enough__false
    assert_equal(false, @bar.guest_old_enough?(@guest3))
  end

  def test_guest_can_buy_drink
    @big_room.checkin_guest(@bar, @guest2)
    @bar.serve_drink(@beer, @guest2)
    assert_equal([@vodka, @wine, @coke], @bar.drinks_stock) # testing drink has been removed from bar's drink stock
    assert_equal(10, @bar.till) # testing cost of drink has been added to bar till (which doesn't take in entry fee)
    assert_equal([@beer], @guest2.purchases) # testing drink has been added to guest's purchases
    assert_equal(10, @guest2.wallet) # testing correct money has been taken off guest (includes entry fee as checkin function called to create bar tab)
    assert_equal([{name: "Ivan", tab: 20}], @bar.guest_tabs) # testing bar tab tracks guest spending (entry fee and drink purchase)
  end

  def test_guest_can_buy_food
    @big_room.checkin_guest(@bar, @guest2)
    @bar.serve_food(@pasta, @guest2)
    assert_equal([@side], @bar.food_stock)
    assert_equal(5, @bar.till)
    assert_equal([@pasta], @guest2.purchases)
    assert_equal(15, @guest2.wallet)
    assert_equal([{name: "Ivan", tab: 15}], @bar.guest_tabs)
  end

  def test_guest_cannot_buy_food_that_is_not_in_stock
    @big_room.checkin_guest(@bar, @guest2)
    @bar.serve_food(@sushi, @guest2)
    assert_equal([@pasta, @side], @bar.food_stock)
    assert_equal(0, @bar.till)
    assert_equal([], @guest2.purchases)
    assert_equal(20, @guest2.wallet)
    assert_equal([{name: "Ivan", tab: 10}], @bar.guest_tabs)
  end

  def test_guest_cannot_buy_alcoholic_drink_if_guest_too_young
    @big_room.checkin_guest(@bar, @guest3)
    @bar.serve_drink(@beer, @guest3)
    assert_equal([@beer, @vodka, @wine, @coke], @bar.drinks_stock)
    assert_equal(0, @bar.till)
    assert_equal([], @guest3.purchases)
    assert_equal(30, @guest3.wallet)
    assert_equal([{name: "Archie", tab: 10}], @bar.guest_tabs)
  end

  def test_underage_guest_can_buy_non_alcoholic_drinks
    @big_room.checkin_guest(@bar, @guest3)
    @bar.serve_drink(@coke, @guest3)
    assert_equal([@beer, @vodka, @wine], @bar.drinks_stock)
    assert_equal(5, @bar.till)
    assert_equal([@coke], @guest3.purchases)
    assert_equal(25, @guest3.wallet)
    assert_equal([{name: "Archie", tab: 15}], @bar.guest_tabs)
  end

  def test_guest_cannot_buy_drink_if_guest_cannot_afford
    @big_room.checkin_guest(@bar, @guest1)
    @bar.serve_drink(@beer, @guest1)
    assert_equal([@beer, @vodka, @wine, @coke], @bar.drinks_stock)
    assert_equal(0, @bar.till)
    assert_equal([], @guest1.purchases)
    assert_equal(0, @guest1.wallet)
    assert_equal([{name: "Richard", tab: 10}], @bar.guest_tabs)
  end

  def test_guest_cannot_buy_food_if_guest_cannot_afford
    @big_room.checkin_guest(@bar, @guest1)
    @bar.serve_food(@pasta, @guest1)
    assert_equal([@pasta, @side], @bar.food_stock)
    assert_equal(0, @bar.till)
    assert_equal([], @guest1.purchases)
    assert_equal(0, @guest1.wallet)
    assert_equal([{name: "Richard", tab: 10}], @bar.guest_tabs)
  end



end
