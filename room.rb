class Room

  attr_reader :name, :capacity, :playlist, :guests, :entrance_fee, :till

  def initialize(name, capacity, entrance_fee, playlist)
    @name = name
    @capacity = capacity
    @entrance_fee = entrance_fee.to_i
    @playlist = playlist || []
    @guests = []
    @till = 0
  end

  def add_song_to_playlist(song)
    @playlist << song
  end

  def play_playlist
    return if @playlist = []
    for current_song in playlist
      return song.play(current_song)
    end
  end

  def capacity_met?
    return guests.length >= @capacity
  end

  def guest_can_afford_entrance?(guest)
    return guest.wallet >= @entrance_fee
  end

  def checkin_guest(bar, guest)
    return if capacity_met?
    return if !guest_can_afford_entrance?(guest)
    @guests << guest
    guest.pay_entrance_fee(self)
    @till += @entrance_fee
    bar.create_guest_tab(guest, self)
  end

  def find_guest(guest_to_find)
    return guests.find { |guest| guest == guest_to_find }
  end

  def checkout_guest(guest)
    @guests.delete(find_guest(guest)) if @guests.include?(guest)
  end

end
