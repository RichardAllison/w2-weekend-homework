require_relative("order.rb")

class Drink < Order

  attr_reader :name, :price, :order_type, :drink_type

    def initialize(name, price, drink_type)
      super(name, price, "drink")
      @drink_type = drink_type
    end

end
