class Guest

  attr_reader :name, :age, :wallet

  def initialize(name, age, wallet)
    @name = name
    @age = age
    @wallet = wallet
    # @favourite_song = favourite_song
  end

  def pay_entrance_fee(room)
    @wallet -= room.entrance_fee
  end

  # def cheer_favourite_song
  #   room.play_playlist
  #   for song in playlist
  #     if song_name == @favourite_song
  #       return "Whoo!"
  #     end
  #   end
  # end



end
