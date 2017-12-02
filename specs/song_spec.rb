require("minitest/autorun")
require("minitest/rg")
require_relative("../song.rb")

class TestSong < MiniTest::Test

  def setup
    @song = Song.new("Random song", "Random artist")
  end

  def test_song_has_name
    assert_equal("Random song", @song.name)
  end

  def test_song_has_artist
    assert_equal("Random artist", @song.artist)
  end

  def test_song_plays
    assert_equal("Now playing Random song by Random artist", @song.play)
  end
end
