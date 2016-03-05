class PaymentsController < ApplicationController
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      drivers = payment.add_driver
      flash["message"] = "Thank You For Pre Registering"
      redirect_to thanks_path
      driver_class = JoinMail.new(drivers[0], drivers[1])
      sleep(1)
      driver_class.send!
    else
      flash["error"] = "Payment Failed"
      redirect_to events_path(params[:id])
    end
  end
end
