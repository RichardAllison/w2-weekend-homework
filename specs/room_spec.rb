require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../guest.rb")
require_relative("../song.rb")
require_relative("../bar.rb")

class TestRoom < MiniTest::Test

  def setup
    @song1 = Song.new("Bohemian Rhapsody", "Queen")
    @song2 = Song.new("Rockin' all over the world","Status Quo")
    @song3 = Song.new("Blueberry Hill","Fats Domino")
    @song4 = Song.new("If","Bread")
    @song5 = Song.new("School's Out","Alice Cooper")
    songs = [@song1, @song2, @song4, @song5]

    @big_room = Room.new("Big room", 50, 10, songs)
    @small_room = Room.new("Small room", 5, 10, songs)

    @bar = Bar.new("CodeClan Caraoke Bar", [], [])

    @guest1 = Guest.new("Richard", 29, 20, "It won't go")
    @guest2 = Guest.new("Ivan", 32, 30, "Rockin' all over the world")
    @guest3 = Guest.new("Archie", 17, 40, "Blueberry Hill")
    @guest4 = Guest.new("Ahmed", 29, 50, "If")
    @guest5 = Guest.new("Pedro", 23, 60, "School's out")
    @guest6 = Guest.new("Sean", 19, 5, "Bohemian Rhapsody")
    @guest7 = Guest.new("Rob", 40, 70, nil)
  end

  def test_room_has_name
    assert_equal("Big room", @big_room.name)
  end

  def test_room_can_add_songs
    @big_room.add_song_to_playlist(@song3)
    assert_equal([@song1, @song2, @song4, @song5, @song3], @big_room.playlist)
  end

  def test_room_can_remove_songs
    @big_room.remove_song_from_playlist(@song1)
    assert_equal([@song2, @song4, @song5], @big_room.playlist)
  end

  def test_guest_can_afford__true
    assert_equal(true, @small_room.guest_can_afford_entrance?(@guest1))
  end

  def test_guest_can_afford__false
    assert_equal(false, @small_room.guest_can_afford_entrance?(@guest6))
  end

  def test_room_can_checkin_guests
    @big_room.checkin_guest(@bar, @guest1)
    assert_equal([@guest1], @big_room.guests)
  end

  def test_room_can_find_guest
    @big_room.checkin_guest(@bar, @guest1)
    assert_equal(@guest1, @big_room.find_guest(@guest1))
  end

  def test_room_will_not_exceed_capacity
    @small_room.checkin_guest(@bar, @guest1)
    @small_room.checkin_guest(@bar, @guest2)
    @small_room.checkin_guest(@bar, @guest3)
    @small_room.checkin_guest(@bar, @guest4)
    @small_room.checkin_guest(@bar, @guest5)
    @small_room.checkin_guest(@bar, @guest6)
    @small_room.checkin_guest(@bar, @guest7)
    assert_equal(5, @small_room.guests.length)
  end

  def test_room_can_checkout_guests
    @small_room.checkin_guest(@bar, @guest1)
    @small_room.checkin_guest(@bar, @guest2)
    @small_room.checkin_guest(@bar, @guest3)
    assert_equal([@guest1, @guest2, @guest3], @small_room.guests)
    @small_room.checkout_guest(@guest2)
    assert_equal([@guest1, @guest3], @small_room.guests)
  end

  def test_room_can_add_new_guests_after_guest_checked_out
    @small_room.checkin_guest(@bar, @guest1)
    @small_room.checkin_guest(@bar, @guest2)
    @small_room.checkin_guest(@bar, @guest3)
    @small_room.checkout_guest(@guest2)
    assert_equal([@guest1, @guest3], @small_room.guests)
    @small_room.checkin_guest(@bar, @guest7)
    assert_equal([@guest1, @guest3, @guest7], @small_room.guests)
  end

  def test_room_takes_payment
    @big_room.checkin_guest(@bar, @guest1)
   assert_equal(10, @big_room.till)
   assert_equal(10, @guest1.wallet)
  end

  def test_room_takes_payment_multiple_customers
    @big_room.checkin_guest(@bar, @guest1)
    @big_room.checkin_guest(@bar, @guest2)
    @big_room.checkin_guest(@bar, @guest3)
    @big_room.checkin_guest(@bar, @guest4)
    assert_equal(40, @big_room.till)
  end

  def test_room_declines_payment_if_guest_cannot_afford
    @big_room.checkin_guest(@bar, @guest6)
    assert_equal(0, @big_room.till)
    assert_equal(0, @big_room.guests.length)
    assert_equal(5, @guest6.wallet)
  end

  def test_room_declines_payment_if_capacity_reached
    @small_room.checkin_guest(@bar, @guest1)
    @small_room.checkin_guest(@bar, @guest2)
    @small_room.checkin_guest(@bar, @guest3)
    @small_room.checkin_guest(@bar, @guest4)
    @small_room.checkin_guest(@bar, @guest5)
    @small_room.checkin_guest(@bar, @guest7)
    assert_equal(50, @small_room.till)
    assert_equal([@guest1, @guest2, @guest3, @guest4, @guest5], @small_room.guests)
    assert_equal(5, @guest6.wallet)
  end


end
