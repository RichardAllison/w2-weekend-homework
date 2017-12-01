require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../guest.rb")
require_relative("../song.rb")

class TestRoom < MiniTest::Test

  def setup
    @room = Room.new("Big room", 100)
  end

  def test_room_has_name
    assert_equal("Big room", @room.name)
  end


end
