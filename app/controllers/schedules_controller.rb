class SchedulesController < ApplicationController
  def index 
    @events = Event.all
  end
end