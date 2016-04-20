class Payment
  def initialize(params, request)
    @params = params
    @request = request
  end

  def init
    Paypal.sandbox! if Rails.env.development?
  end

  def p_options
   {
      no_shipping: true, # if you want to disable shipping information
      allow_note: false, # if you want to disable notes
      pay_on_paypal: true # if you don't plan on showing your own confirmation step
    }
  end

  def p_request
    Paypal::Express::Request.new(
      :username   => ENV['PAYPAL_USR'],
      :password   => ENV['PAYPAL_PW'],
      :signature  => ENV['PAYPAL_SIG']
    )
  end

  def p_payment_request
    @payment_request = Paypal::Payment::Request.new(
      :currency_code => :USD,   # if nil, PayPal use USD as default
      :description   => "Club Loose North Pre Register",    # item description
      :quantity      => 1,      # item quantity
      :amount        => @params[:amount].to_i / 100 ,   # item value
      :custom_fields => {
        CARTBORDERCOLOR: "D3D3D3",
        LOGOIMG: "https://s3.amazonaws.com/clubloosenorth/cln/images/cln-header1.png"
      }
    )
  end

  def p_response
    p_request.setup(
      p_payment_request,
      host + "/paypals?amount=" + @params[:amount] + "&event_id1=" + @params[:event_id1] + "&event_id2=" + @params[:event_id2] + "&car=" + @params[:car] + "&name=" + @params[:name] + "&note=" + @params[:note] + "&stripe_email=" + @params[:email],
      host,
      p_options  # Optional
    )
  end

 def add_driver
    event1 = Event.find(@params[:event_id1])
    driver = Driver.create(name: @params[:name],
                           email: @params[:stripe_email],
                           car: @params[:car],
                           note: @params[:note],
                           cost_paid: bundle_price,
                           payment_method: "PAYPAL",
                           ref_code: "")
    event1.drivers << driver

    if @params[:event_id2].blank?
      new_driver = nil
    else
      new_driver = Driver.create(name: @params[:name],
                                 email: @params[:stripe_email],
                                 car: @params[:car],
                                 note: @params[:note],
                                 cost_paid: bundle_price,
                                 payment_method: "PAYPAL",
                                 ref_code: "")

      event2 = Event.find(@params[:event_id2])
      event2.drivers << new_driver
    end
    drivers = [driver, new_driver]
    drivers
  end

 private

  def host
    if Rails.env.development?
      @request.host_with_port
    else
      @request.host
    end
  end

  def bundle_price
    if @params[:event_id2].blank?
      return (@params[:amount].to_i / 100).to_f
    else
      return (@params[:amount].to_i / 100).to_f / 2.0
    end
  end
end
