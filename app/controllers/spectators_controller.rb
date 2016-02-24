class SpectatorsController < ApplicationController
  def index
  end

  def create
      event = Event.find(params[:event_id])
      reg_driver = Driver.find(params[:driver_id])
      new_event = Event.find(params[:new_event_id])
      event.drivers.each do |driver|
        if driver.id = reg_driver.id
          Driver.destroy(driver.id)
        end
      end
      event.save
      new_driver = Driver.new reg_driver.dup.attributes.keep_if{|k,v| k!=:id}
      new_driver.save
      new_event.drivers << new_driver
      flash[:success] = "Driver successfully moved"
      redirect_to "/events/#{new_event.id}/drivers"
  end
end
