class Room

  attr_reader :name, :capacity, :playlist, :guests, :entrance_fee, :till

  def initialize(name, capacity, entrance_fee, playlist)
    @name = name
    @capacity = capacity
    @entrance_fee = entrance_fee
    @playlist = playlist || []
    @guests = []
    @till = 0
  end

  def add_song_to_playlist(song)
    @playlist << song
  end

  def capacity_met?
    return guests.length >= @capacity
  end

  def guest_can_afford?(guest)
    return guest.wallet >= @entrance_fee
  end

  def checkin_guest(guest)
    return if capacity_met?
    @guests << guest
    @till += guest.wallet
  end

  def find_guest(guest_to_find)
    return guests.find { |guest| guest == guest_to_find }
  end

  def checkout_guest(guest)
    @guests.delete(find_guest(guest)) if @guests.include?(guest)
  end



  # def payment - only take off money if below capacity (allowed in) and if can afford

end
