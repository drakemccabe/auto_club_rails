class EventsController < ApplicationController
  def index
    @events = Event.where("date > current_date").order(:date).limit(3)
    event = @events.first.date
    @next_event = next_event_time(event)
  end

  def show
    @event = Event.find(params[:id])
    binding.pry
    if @event.is_bundle?
      @two_pack = BundlePack.new(date_check(@event)).pack
    end
  end

  def new
    @event = Event.new
  end

  def create
    binding.pry
    new_event = Event.new(event_params)

    if new_event.save
      #flash
    else
      #flash
    end
  end

  private

  def next_event_time(event_time)
    ((event_time - Date.today).to_i * 86400) + 32400
  end

  def event_params
    params.require(:event).permit(:id, :price, :name, :date, :location)
  end
end
