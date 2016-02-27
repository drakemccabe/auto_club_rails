class PaymentsController < ApplicationController
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      drivers = payment.add_driver
      JoinMail.new(drivers[0], driver[1]).send!
      flash["message"] = "Thank You For Pre Registering"
      redirect_to thanks_path
    else
      flash["error"] = "Payment Failed"
      redirect_to events_path(params[:id])
    end
  end
end
