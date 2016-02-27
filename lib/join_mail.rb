require 'mailgun'

class JoinMail
  def initialize(driver, new_driver)
    @driver = driver
    @new_driver = new_driver
    @mg_client = Mailgun::Client.new ENV["MAILGUN"]
  end

  def message
    {:from    => 'noreply@clubloose-north.com',
     :to      => @driver.email,
     :subject => 'Your Club Loose North Prereg',
     :text    => "Hey #{@driver.name}, you\'re all clear to shred on " + events(@driver) + events(@new_driver) + "."}
  end

  def events(driver_var)
    if driver_var.nil?
      return ""
    else
      driver_var.events.first.date.strftime("%a, %b #{@driver.events.first.date.day.ordinalize}")
    end
  end

  def send!
    @mg_client.send_message "noreply.clubloose-north.com", message
  end
end
