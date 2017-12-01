require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../guest.rb")
require_relative("../song.rb")

class TestRoom < MiniTest::Test

  def setup
    @big_room = Room.new("Big room", 50)
    @small_room = Room.new("Small room", 10)
    @guest = Guest.new("Richard Allison", 20)
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
    @big_room.checkin_guest(@guest)
    assert_equal(1, @big_room.guests.length)
  end


end
