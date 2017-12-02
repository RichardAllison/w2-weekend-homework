require("minitest/autorun")
require("minitest/rg")
require_relative("../guest.rb")
require_relative("../room.rb")
require_relative("../song.rb")


class TestGuest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Richard", 29, 20, "Bohemian Rhapsody")
    @song1 = Song.new("Bohemian Rhapsody", "Queen")
    @song2 = Song.new("Rockin' all over the world","Status Quo")
    @small_room = Room.new("Small room", 5, 10, [@song1])
    @big_room = Room.new("Big room", 10, 10, [@song2])
  end

  def test_guest_has_name
    assert_equal("Richard", @guest1.name)
  end

  def test_guest_cheers_favourite_song
    assert_equal("Whoo!", @guest1.cheer_favourite_song(@small_room))
  end

  def test_guest_not_cheering_if_playlist_empty
    @small_room.remove_song_from_playlist(@song1)
    assert_nil(@guest1.cheer_favourite_song(@small_room))
  end

  def test_guest_not_cheering_if_song_not_in_playlist
    assert_nil(@guest1.cheer_favourite_song(@big_room))
  end

end
