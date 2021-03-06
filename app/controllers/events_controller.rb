class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @seasons = Season.where("expires >= ?", Date.today)
    @events = Event.where("date >= :start_date AND date <= :end_date", {start_date: Date.today - 2.days, end_date: Time.now.end_of_year}).order(:date)
    @params = params
  end

  def show
    @event = Event.find(params[:id])
    @limit = @event.driver_limit || 40
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
       client = SendGrid::Client.new(api_key: ENV["SENDGRID"])

      event.drivers.each do |driver|
      mail = SendGrid::Mail.new do |m|
        m.to = driver.email
        m.from = 'noreply@clubloosenorth.com'
        m.subject = 'Important Info About Your Club Loose North Registration.'
        m.html = params[:message]
      end
        client.send(mail)
      end

    else
      event.update(event_params)
    end
    flash[:message] = "Event Updated"
    redirect_to event_path(params[:id])
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:alert] = "Event Destroyed"
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:id, :driver_limit, :price, :name, :date, :location, :facebook_url, :photo_url)
  end
end
