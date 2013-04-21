class Item

  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = Money.new(price * 100) # Money#initialize gets value in pennies, not in pounds
  end
end