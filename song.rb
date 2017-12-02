class Song

  attr_reader :name, :artist

  def initialize(name, artist)
    @name = name
    @artist = artist
  end

  def play
    return "Now playing #{@name} by #{@artist}"
  end

end
