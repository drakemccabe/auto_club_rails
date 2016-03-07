class PaymentsController < ApplicationController
  require 'sendgrid-ruby'
  
  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      drivers = payment.add_driver
      flash["message"] = "Thank You For Pre Registering"
      redirect_to thanks_path
      
      driver_class = JoinMail.new(drivers[0], drivers[1])
      message = driver_class.create_mssg
      
      client = SendGrid::Client.new(api_key: ENV["SENDGRID"])
      
      mail = SendGrid::Mail.new do |m|
  m.to = params[:email]
  m.from = 'noreply@clubloosenorth.com'
  m.subject = 'Your Club Loose North Driver Registration'
  m.html = message
end

      res = client.send(mail)
      

      #sleep(1)
      #driver_class.send!
    else
      flash["error"] = "Payment Failed"
      redirect_to events_path(params[:id])
    end
  end
end
