class HomesController < ApplicationController
  def index
    @event = Event.where("date > current_date").first
    unless @event
      @event = Event.new
      @event.name = "To Be Announced"
      @event.date = DateTime.civil_from_format :local, 2017, 04, 01
    end
    @box = Box.find(1)
  end

  private

  def next_event_time(event_time)
    ((event_time - Date.today).to_i * 86400) + 32400
  end
end
