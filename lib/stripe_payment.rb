class StripePayment
  def initialize(params)
    @params = params
    @charge = ""
  end

  def charge
    customer = Stripe::Customer.create(card: @params[:stripeToken],
                                       email: @params[:stripeEmail],
                                       description: "ClubLoose North")

    @charge = Stripe::Charge.create(amount: @params[:amount],
                                   currency: "usd",
                                   customer: customer.id)
  end

  def add_driver
    event1 = Event.find(@params[:event_id1])
    driver = Driver.create(name: @params[:name],
                           email: @params[:stripeEmail],
                           car: @params[:car],
                           note: @params[:note])
    event1.drivers << driver

    if @params[:event_id2].blank?
      new_driver = nil
    else
      new_driver = Driver.create(name: @params[:name],
                                 email: @params[:stripeEmail],
                                 car: @params[:car],
                                 note: @params[:note])

      event2 = Event.find(@params[:event_id2])
      event2.drivers << new_driver
    end
    drivers = [driver, new_driver]
    drivers
  end

  def successful?
    @charge.paid
  end
end
