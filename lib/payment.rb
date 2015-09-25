class Payment
  def initialize(price, name)
    @price = price
    @name = name
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
      :username   => "drakemccabe-facilitator_api1.gmail.com",
      :password   => "7GNJR5P3GH22QE6Y",
      :signature  => "An5ns1Kso7MWUdW4ErQKJJJ4qi4-Aqf0zLbZIpqMEqa2WuI8wxO0w0Iv"
    )
  end

  def p_payment_request
    @payment_request = Paypal::Payment::Request.new(
      :currency_code => :USD,   # if nil, PayPal use USD as default
      :description   => $DESC,    # item description
      :quantity      => 1,      # item quantity
      :amount        => $VAL,   # item value
      :custom_fields => {
        CARTBORDERCOLOR: "C00000",
        LOGOIMG: "https://example.com/logo.png"
      }
    )
  end

  def p_response
    p_request.setup(
      p_payment_request,
      "http://dev.drakemccabe.com/success/item",
      "http://dev.drakemccabe.com/cancel",
      p_options  # Optional
    )
  end
end
