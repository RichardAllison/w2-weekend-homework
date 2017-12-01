class Room

  attr_reader :name, :capacity, :playlist, :guests

  def initialize(name, capacity)
    @name = name
    @capacity = capacity
    @playlist = []
    @guests = []
  end

  def add_song_to_playlist(song)
    @playlist << song
  end

  def checkin_guest(guest)
    return if @guests.length > @capacity
    @guests << guest
  end

end
