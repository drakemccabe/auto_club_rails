class BundlePack
  attr_accessor :price, :prices, :name, :dates, :ids

  def initialize(events)
    @events = events
    @price = (@events.first.price + @events.last.price) - 10
    @prices = [@events.first.price, @events.last.price]
    @name = @events.first.name + " and " + @events.last.name
    @dates = [@events.first.date, @events.last.date]
    @ids = [@events.last.id, @events.last.id]
  end

  def pack
    @price = (@events.first.price + @events.last.price) - 10
    @prices = [@events.first.price, @events.last.price]
    @name = @events.first.name + " and " + @events.last.name
    @dates = [@events.first.date, @events.last.date]
    @ids = [@events.first.id, @events.last.id]
    return self
  end

  def second_price(id)
    prices = {}
    prices[@ids[0]] = @prices[0]
    prices[@ids[1]] = @prices[1]
    return prices.except(id).values[0]
  end
end
