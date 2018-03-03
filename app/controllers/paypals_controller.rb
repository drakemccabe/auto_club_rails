class PaypalsController < ApplicationController
  include SendGrid
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
      unless params[:season] == "true"
        driver_class = JoinMail.new(drivers[0], drivers[1])
        message = driver_class.create_mssg

        sg = SendGrid::API.new(api_key: ENV["SENDGRID"])

        from = Email.new(email: 'noreply@clubloosenorth.com')
        to = Email.new(email: params[:stripe_email])
        subject = 'Your Club Loose North Driver Registration'
        content = Content.new(type: 'text/html', value: message)
        mail = Mail.new(from, subject, to, content)

         response = sg.client.mail._('send').post(request_body: mail.to_json)
        redirect_to thanks_path
      else
        redirect_to thanks_path
      end
     return
    else
      flash["error"] = "Payment Failed"
      redirect_to "/paypals/1"
    end
  end
  def show
  end
end
