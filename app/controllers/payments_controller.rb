class PaymentsController < ApplicationController
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      driver = payment.add_driver
      JoinMail.new(driver).send!
      flash["message"] = "Thank You For Pre Registering"
      redirect_to events_path(params[:id])
    else
      redirect_to events_path(params[:id])
    end
  end
end
