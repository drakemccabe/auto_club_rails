class PaymentsController < ApplicationController
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      driver = payment.add_driver
      JoinMail.new(driver).send!
      flash["message"] = "Thank You For Pre Registering"
      redirect_to thanks_path
    else
      flash["error"] = "Payment Failed"
      redirect_to events_path(params[:id])
    end
  end
end
