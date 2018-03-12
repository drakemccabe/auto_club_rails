class PaymentsController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid

  def create
    payment = StripePayment.new(params)
    payment.charge
    if payment.successful?
      drivers = payment.add_driver
      flash["message"] = "Thank You For Pre Registering"

      unless params[:season] == "true"
        driver_class = JoinMail.new(drivers[0], drivers[1])
        message = driver_class.create_mssg

        sg = SendGrid::API.new(api_key: ENV["SENDGRID"])

        from = Email.new(email: 'noreply@clubloosenorth.com')
        to = Email.new(email: params["stripeEmail"])
        subject = 'Your Club Loose North Driver Registration'
        content = Content.new(type: 'text/html', value: message)
        mail = Mail.new(from, subject, to, content)

        sg.client.mail._('send').post(request_body: mail.to_json)
      end
      redirect_to thanks_path
     return
    else
      flash["error"] = "Payment Failed"
      redirect_to "/paypals/1"
    end
  end
end
