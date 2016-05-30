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
      allow_note: true, # if you want to disable notes
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
      :amount        => (@params[:amount].to_i / 100).to_f ,   # item value
      :custom_fields => {
        CARTBORDERCOLOR: "D3D3D3",
        LOGOIMG: "https://s3.amazonaws.com/clubloosenorth/cln/images/cln-header1.png"
      }
    )
  end

  def p_response
    p_request.setup(
      p_payment_request,
      "http://" + host + "/paypals?amount=" + URI::escape(@params[:amount]) + "&event_id1=" + URI::escape(@params[:event_id1]) + "&event_id2=" + URI::escape(@params[:event_id2]) + "&car=" + URI::escape(@params[:car]) + "&name=" + URI::escape(@params[:name]) + "&note=" + URI::escape(@params[:note]) + "&stripe_email=" + URI::escape(@params[:email]),
       "http://" + host,
      p_options  # Optional
    )
  end
  
  def test1
    host + "/paypals?amount=" + URI::escape(@params[:amount]) + "&event_id1=" + URI::escape(@params[:event_id1]) + "&event_id2=" + URI::escape(@params[:event_id2]) + "&car=" + URI::escape(@params[:car]) + "&name=" + URI::escape(@params[:name]) + "&note=" + URI::escape(@params[:note]) + "&stripe_email=" + URI::escape(@params[:email])
  end
  
 def add_driver(response)
    event1 = Event.find(@params[:event_id1])
    driver = Driver.create(name: @params[:name],
                           email: @params[:stripe_email],
                           car: @params[:car],
                           note: @params[:note],
                           cost_paid: bundle_price,
                           payment_method: "PAYPAL",
                           ref_code: response.payment_info[0].transaction_id )
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
                                 ref_code: response.payment_info[0].transaction_id )

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
