require_relative("order.rb")

class Drink < Order

  attr_reader :name, :price, :order_type, :drink_typem, :alcohol_content

    def initialize(name, price, drink_type, alcohol_content)
      super(name, price, "drink")
      @drink_type = drink_type
      @alcohol_content = alcohol_content
    end

end
