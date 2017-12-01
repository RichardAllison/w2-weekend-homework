require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../guest.rb")
require_relative("../song.rb")

class TestRoom < MiniTest::Test

  def setup
    @big_room = Room.new("Big room", 50, 10, [])
    @small_room = Room.new("Small room", 5, 10, [])
    @guest1 = Guest.new("Richard", 20)
    @guest2 = Guest.new("Seamus", 30)
    @guest3 = Guest.new("David", 40)
    @guest4 = Guest.new("Andrew", 50)
    @guest5 = Guest.new("Christopher", 60)
    @guest6 = Guest.new("Sean", 5)
    @guest7 = Guest.new("Bob", 70)
    @song = Song.new("Random song", "Random artist")
  end

  def test_room_has_name
    assert_equal("Big room", @big_room.name)
  end

  def test_room_can_add_songs
    @big_room.add_song_to_playlist(@song)
    assert_equal(1, @big_room.playlist.length)
  end

  def test_room_can_checkin_guests
    @big_room.checkin_guest(@guest1)
    assert_equal(1, @big_room.guests.length)
  end

  def test_room_can_find_guest
    @big_room.checkin_guest(@guest1)
    assert_equal(@guest1, @big_room.find_guest(@guest1))
  end

  def test_room_will_not_exceed_capacity
    @small_room.checkin_guest(@guest1)
    @small_room.checkin_guest(@guest2)
    @small_room.checkin_guest(@guest3)
    @small_room.checkin_guest(@guest4)
    @small_room.checkin_guest(@guest5)
    @small_room.checkin_guest(@guest6)
    assert_equal(5, @small_room.guests.length)
  end

  def test_room_can_checkout_guests
    @small_room.checkin_guest(@guest1)
    @small_room.checkin_guest(@guest2)
    @small_room.checkin_guest(@guest3)
    @small_room.checkout_guest(@guest2)
    assert_equal(2, @small_room.guests.length)
    assert_equal([@guest1, @guest3], @small_room.guests)
  end

  def test_guest_can_afford__true
    assert_equal(true, @small_room.guest_can_afford?(@guest1))
  end

  def test_guest_can_afford__false
    assert_equal(false, @small_room.guest_can_afford?(@guest6))
  end

  def test_room_takes_payment
    @big_room.checkin_guest(@guest1)
   assert_equal(10, @big_room.till)
   assert_equal(10, @guest1.wallet)
  end

  def test_room_takes_payment_multiple_customers
    @big_room.checkin_guest(@guest1)
    @big_room.checkin_guest(@guest2)
    @big_room.checkin_guest(@guest3)
    @big_room.checkin_guest(@guest4)
    assert_equal(40, @big_room.till)
  end

  def test_room_declines_payment_if_guest_cannot_afford
    @big_room.checkin_guest(@guest6)
    assert_equal(0, @big_room.till)
    assert_equal(0, @big_room.guests.length)
    assert_equal(5, @guest6.wallet)
  end

  def test_room_declines_payment_if_capacity_reached
    @small_room.checkin_guest(@guest1)
    @small_room.checkin_guest(@guest2)
    @small_room.checkin_guest(@guest3)
    @small_room.checkin_guest(@guest4)
    @small_room.checkin_guest(@guest5)
    @small_room.checkin_guest(@guest7)
    assert_equal(50, @small_room.till)
    assert_equal([@guest1, @guest2, @guest3, @guest4, @guest5], @small_room.guests)
    assert_equal(5, @guest6.wallet)
  end

end
