require("minitest/autorun")
require("minitest/rg")
require_relative("../guest.rb")
require_relative("../room.rb")
require_relative("../song.rb")


class TestGuest < MiniTest::Test

  def setup
    @song1 = Song.new("Bohemian Rhapsody", "Queen")
    @small_room = Room.new("Small room", 5, 10, [@song1])
    @guest1 = Guest.new("Richard", 29, 20, "Bohemian Rhapsody")
  end

  def test_guest_has_name
    assert_equal("Richard", @guest1.name)
  end

  def test_guest_cheers_favourite_song
    assert_equal("Whoo!", @guest1.cheer_favourite_song(@small_room))
  end

end
