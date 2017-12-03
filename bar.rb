class Bar

  attr_reader :name, :guest_tabs, :drinks_stock, :food_stock, :till
  def initialize(name, drinks_stock, food_stock)
    @name = name
    @guest_tabs = []
    @drinks_stock = drinks_stock || []
    @food_stock = food_stock || []
    @till = 0
  end

  def create_guest_tab(guest, room)
    @guest_tabs << {
      name: guest.name,
      tab: room.entrance_fee
    }
  end

  def track_guest_spending(guest, order)
    for guest_tab in @guest_tabs
      if guest_tab[:name] == guest.name
        guest_tab[:tab] += order.price
      end
    end
  end

  def find_guest_tab_by_name(name)
    return @guest_tabs.find { |guest| guest[:name] == name }
  end

  # Code for selling food and drinks below, so that tracking spending has something to track!

  def find_drink_by_name(name)
    return @drinks_stock.find { |drink| drink.name == name }
  end

  def find_food_by_name(food_name)
    return @food_stock.find { |food| food.name == food_name }
  end

  def guest_old_enough?(guest)
    guest.age >= 18
  end

  def serve_drink(drink, guest)
    return if drink.alcohol_content > 0 && !guest_old_enough?(guest)
    if @drinks_stock.include?(drink)
      guest.buy(drink)
      drink_sold = find_drink_by_name(drink.name)
      guest.purchases << @drinks_stock.delete(drink_sold)
      @till += drink_sold.price
      track_guest_spending(guest, drink)
    end
  end

  def serve_food(food, guest)
    if @food_stock.include?(food)
      guest.buy(food)
      food_sold = find_food_by_name(food.name)
      guest.purchases << @food_stock.delete(food_sold)
      @till += food_sold.price
      track_guest_spending(guest, food)
    end
  end

end
