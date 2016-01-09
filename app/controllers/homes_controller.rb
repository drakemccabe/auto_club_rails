class HomesController < ApplicationController
  def index
    @event = Event.where("date > current_date").first
    @next_event = next_event_time(@event.date)
  end

  private

  def next_event_time(event_time)
    ((event_time - Date.today).to_i * 86400) + 32400
  end
end
