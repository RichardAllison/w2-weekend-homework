require_relative("order.rb")

class Food < Order

  attr_reader :name, :price, :order_type, :food_type

    def initialize(name, price, food_type)
      super(name, price, "food")
      @food_type = food_type
    end

end
