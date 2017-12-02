class Guest

  attr_reader :name, :age, :wallet, :favourite_song

  def initialize(name, age, wallet, favourite_song)
    @name = name
    @age = age
    @wallet = wallet
    @favourite_song = favourite_song
  end

  def pay_entrance_fee(room)
    @wallet -= room.entrance_fee
  end

  def cheer_favourite_song(room)
    for song in room.playlist
      if song.name == @favourite_song
        return "Whoo!"
      end
    end
    return nil
  end



end
