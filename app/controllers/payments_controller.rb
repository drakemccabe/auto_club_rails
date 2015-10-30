class PaymentsController < ApplicationController
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      driver = payment.add_driver
      JoinMail.new(driver).send!
    else
      redirect_to events_path(params[:id])
    end
  end
end
