class Song

  attr_reader :name, :artist

  def initialize(name, artist)
    @name = name
    @artist = artist
  end

  def play(name)
    return "Now playing #{name}"
  end

end
