require 'mailgun'

class JoinMail
  def initialize(driver, new_driver)
    @driver = driver
    @new_driver = new_driver
    @mg_client = Mailgun::Client.new ENV["MAILGUN"]
    @message = message
  end

  def message
    {:from    => 'noreply@clubloose-north.com',
     :to      => @driver.email,
     :subject => 'Your Club Loose North Prereg',
     :text    => "Hey #{@driver.name}, you\'re all clear to shred on " + events(@driver) + " " + events(@new_driver) + "." + " In the meantime, read the driver faq on the Club Loose North site, brush up on the rulebook, and email info@clubloose-north.com " + "with any questions or concerns. Thanks for pre-registering. -Russ Barcomb" }
  end

  def create_mssg
   return "<p>Hey #{@driver.name}, you\'re all clear to shred on #{events(@driver)} #{events(@new_driver)}!</p><p>In the meantime, read the <a href='http://www.clubloose-north.com/faqs'>driver\'s FAQ</a>, brush up on the <a href='http://www.clubloose-north.com/faqs/rules'>official rulebook and run schedule (important!)</a>, and email info@clubloose-north.com with any questions or concerns.</p><p>Thanks for pre-registering and supporting Club Loose North.</p><p>-Russ Barcomb</p><br><br><p>Please do not reply to this message</p>"
  end

  def events(driver_var)
    if driver_var.nil?
      return ""
    else
      driver_var.events.first.date.strftime("%a, %b #{driver_var.events.first.date.day.ordinalize}")
    end
  end

  def send!
    @mg_client.send_message "noreply.clubloose-north.com", @message
  end
end




