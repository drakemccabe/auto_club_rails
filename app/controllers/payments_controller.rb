class PaymentsController < ApplicationController
  require 'sendgrid-ruby'

  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      drivers = payment.add_driver
      flash["message"] = "Thank You For Pre Registering"

      driver_class = JoinMail.new(drivers[0], drivers[1])
      message = driver_class.create_mssg

      client = SendGrid::Client.new(api_key: ENV["SENDGRID"])

      mail = SendGrid::Mail.new do |m|
        m.to = params[:stripeEmail]
        m.from = 'noreply@clubloosenorth.com'
        m.subject = 'Your Club Loose North Driver Registration'
        m.html = message
      end
     res = client.send(mail)
      redirect_to thanks_path
     return
    else
      flash["error"] = "Payment Failed"
      redirect_to "/paypals/1"
    end
  end
end
