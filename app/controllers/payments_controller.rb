class PaymentsController < ApplicationController
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      payment.add_driver
    else
      redirect_to events_path(params[:id])
    end
  end
end
