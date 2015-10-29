class DriversController < ApplicationController
  respond_to :csv

  def index
    event = Event.find(params[:event_id])
    drivers = event.drivers
    respond_to do |format|
      format.csv { render csv: drivers }
      format.html { render :index, locals: { drivers: drivers, event: event } }
    end
  end
end
