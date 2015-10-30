require 'mailgun'

class JoinMail
  def initialize(driver)
    @driver = driver
    @mg_client = Mailgun::Client.new ENV["MAILGUN"]
  end

  def message
    {:from    => 'noreply@clubloose-north.com',
     :to      => @driver.email,
     :subject => 'Your Club Loose North Prereg',
     :text    => "Hey #{@driver.name}, you\'re all clear to shred on " + events + "."}
  end

  def events
    if @driver.events.length == 2
      @driver.events.first.date.strftime("%a, %b #{@driver.events.first.date.day.ordinalize}") +
      " and " + @driver.events.last.date.strftime("%a, %b #{@driver.events.last.date.day.ordinalize}")
    else
      @driver.events.first.date.strftime("%a, %b #{@driver.events.first.date.day.ordinalize}")
    end
  end

  def send!
    @mg_client.send_message "noreply.clubloose-north.com", message
  end
end
