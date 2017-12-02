class Order

attr_reader :name, :price

  def initialize(name, price, order_type)
    @name = name
    @price = price
    @order_type = order_type
  end

end
