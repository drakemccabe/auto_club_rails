class Season < ActiveRecord::Base
  has_many :attendees
  has_many :drivers, :through => :attendees
  has_many :events

  validates :name, presence: true
  validates :price, presence: true
  validates :expires, presence: true
  validates :description, presence: true
  validates :year, presence: true, uniqueness: true

  def add_to_events_paypal(params, price, response)
    self.events.each do |event|
      new_driver = Driver.create(name: params[:name],
                           email: params[:stripe_email],
                           car: params[:car],
                           note: params[:note],
                           cost_paid: price,
                           payment_method: "PAYPAL",
                           ref_code: response.payment_info[0].transaction_id )

      event.drivers << new_driver
      event.save
    end
  end

  def add_to_events_stripe(params, price)
    self.events.each do |event|
      new_driver = Driver.create(name: params[:name],
                                 email: params[:stripeEmail],
                                 car: params[:car],
                                 note: params[:note],
                                 cost_paid: price,
                                 payment_method: "STRIPE",
                                 ref_code: params[:stripeToken])


      event.drivers << new_driver
    end
  end

end
