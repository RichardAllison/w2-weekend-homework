require("minitest/autorun")
require("minitest/rg")
require_relative("../bar.rb")
require_relative("../room.rb")
require_relative("../guest.rb")

class TestBar < MiniTest::Test

  def setup
    @big_room = Room.new("Big room", 50, 10, [])
    @small_room = Room.new("Small room", 5, 10, [])
    rooms = [@big_room, @small_room]
    @bar = Bar.new("CodeClan Caraoke Bar", rooms)
    @guest1 = Guest.new("Richard", 29, 20)
    @guest2 = Guest.new("Ahmed", 32, 30)
    @guest3 = Guest.new("Archie", 17, 40)
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
    assert_equal([{name: "Richard", tab: 10},{name: "Ahmed", tab: 10},{name: "Archie", tab: 10}], @bar.guest_tabs)
  end

  def test_find_bar_tab_by_name
    @bar.create_guest_tab(@guest1, @big_room)
    @bar.create_guest_tab(@guest2, @big_room)
    @bar.create_guest_tab(@guest3, @big_room)
    found_guest_tab = @bar.find_guest_tab_by_name("Richard")
    assert_equal(found_guest_tab, {name: "Richard", tab: 10})
  end

  def test_room_checkin_creates_bar_tab
    @big_room.checkin_guest(@bar, @guest1)
    assert_equal([{name: "Richard", tab: 10}], @bar.guest_tabs)
  end

end
