class DriversController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  respond_to :csv

  def index
    @events = Event.all
    event = Event.find(params[:event_id])
    drivers = event.drivers
    respond_to do |format|
      format.csv { render csv: drivers }
      format.html { render :index, locals: { drivers: drivers, event: event } }
    end
  end

  def create
    binding.pry
    event = Event.find(params[:event_id])
    reg_driver = Driver.find(params[:driver_id])
    new_event = Event.find(params[:new_event_id])
    event.drivers.each do |driver|
      if driver.id = reg_driver.id
        driver.destroy
      end
    end
    event.save
    new_event << reg_driver
  end
end
