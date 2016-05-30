class PaypalsController < ApplicationController
  def create
    payment = Payment.new(params, request)
    payment.init
    payment.p_options
    payment.p_request
    payment.p_payment_request
    payment.p_response
    redirect_to(payment.p_response.redirect_uri)
  end

  def index
    payment = Payment.new(params, request)
    payment.init
    response = payment.p_request.checkout!(
    params[:token],
    params[:PayerID],
    payment.p_payment_request
  )
    unless response.nil?
      drivers = payment.add_driver(response)
      driver_class = JoinMail.new(drivers[0], drivers[1])
      message = driver_class.create_mssg

      client = SendGrid::Client.new(api_key: ENV["SENDGRID"])

      mail = SendGrid::Mail.new do |m|
        m.to = params[:stripe_email]
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
  def show
  end
end
