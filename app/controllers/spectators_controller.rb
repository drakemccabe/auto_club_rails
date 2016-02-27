class SpectatorsController < ApplicationController
  def index
  end

  def create
      event = Event.find(params[:event_id])
      if params[:driver_id].present?
        reg_driver = Driver.find(params[:driver_id])
        new_event = Event.find(params[:new_event_id])
        event.drivers.each do |driver|
          if driver.id == reg_driver.id
            Driver.destroy(driver.id)
          end
        end
        event.save
        new_driver = Driver.new reg_driver.dup.attributes.keep_if{|k,v| k!=:id}
        new_driver.save
        new_event.drivers << new_driver
        flash[:error] = "Driver successfully moved"
        redirect_to "/events/#{new_event.id}/drivers"
      else
        d = Driver.new(name: params[:name],
                   car: params[:car],
                   email: params[:email],
                   note: params[:note]
        )

        d.save
        event.drivers << d
        flash[:success] = "Driver Added"
          redirect_to "/events/#{event.id}/drivers"
      end
  end
end
