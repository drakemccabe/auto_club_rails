class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #before_filter :redirect_to_https, only: [:show]

  def index
    @events = Event.all.order(:date).limit(20)
    unless Rails.env.development?
      @photos = HTTParty.get("https://api.instagram.com/v1/tags/clubloosenorth/media/recent?client_id=bb3a3552e0a14419ae2805c8d0735728")
    end
    @calendar = @events.group_by { |t| t.date.beginning_of_month }.stringify_keys
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
        res = client.send(mail)
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
