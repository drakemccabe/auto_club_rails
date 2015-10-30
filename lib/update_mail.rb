require 'mailgun'

class UpdateMail
  def initialize(message, event)
    @message = message
    @event = event
    @mg_client = Mailgun::Client.new ENV["MAILGUN"]
    @mb_obj = Mailgun::BatchMessage.new(@mg_client, "noreply.clubloose-north.com")
  end

  def message
    @mb_obj.set_from_address("noreply@clubloose-north.com", {"first"=>"ClubLoose", "last" => "North"})
    @mb_obj.set_subject("Important Info About Club Loose North's #{@event.date.strftime("%b %d")} event")
    @mb_obj.set_text_body(@message)
  end

  def add_recip
    @event.drivers.each do |driver|
      @mb_obj.add_recipient(:to, driver.email )
    end
  end

  def send!
    message
    add_recip
    @mb_obj.finalize
  end
end
