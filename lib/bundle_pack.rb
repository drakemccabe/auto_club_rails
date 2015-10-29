class BundlePack
  attr_accessor :price, :name, :dates, :ids

  def initialize(events)
    @events = events
    @price = (@events.first.price + @events.last.price) - 20
    @name = @events.first.name + " and " + @events.last.name
    @dates = [@events.first.date, @events.last.date]
    @ids = [@events.last.id, @events.last.id]
  end

  def pack
    @price = (@events.first.price + @events.last.price) - 20
    @name = @events.first.name + " and " + @events.last.name
    @dates = [@events.first.date, @events.last.date]
    @ids = [@events.first.id, @events.last.id]
    return self
  end
end
