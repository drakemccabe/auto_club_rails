class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @events = Event.where("date > current_date").order(:date).limit(3)
  end

  def show
    @event = Event.find(params[:id])
    if @event.is_bundle?
      @two_pack = BundlePack.new(@event.date_check).pack
    end
  end

  def new
    @event = Event.new
  end

  def create
    new_event = Event.new(event_params)

    if new_event.save
      redirect_to new_event
    else
      flash[:error] = new_event.errors.full_messages.join(", ")
      redirect_to root_path
    end
  end

  def edit
    render :new, locals: { :@event => Event.find(params[:id]) }
  end

  def update
    event = Event.find(params[:id])
    if params[:message].present?
      email = UpdateMail.new(params[:message], event)
      email.send!
    else
      event.update(event_params)
    end
    flash[:message] = "Event Updated"
    redirect_to event_path(params[:id])
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:alert] = "Event Destroyed"
    redirect_to event_path(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:id, :price, :name, :date, :location)
  end
end
