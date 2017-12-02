class Bar

  attr_reader :name, :rooms, :guest_tabs
  def initialize(name, rooms)
    @name = name
    @rooms = rooms || []
    @guest_tabs = []
  end

  def create_guest_tab(guest, room)
    @guest_tabs << {
      name: guest.name,
      tab: room.entrance_fee
    }
  end

  # def track_guest_spending(guest, order)
     ##  add order superclass and food and drink classes for this to work
     #  for guest in @guest_tabs
     #   if @guest_tabs[:name] == guest.name
     #     guest[:tab] += order.price
     #   end
     # end
  # end

  def find_guest_tab_by_name(name)
    return @guest_tabs.find { |guest| guest[:name] == name }
  end

end
