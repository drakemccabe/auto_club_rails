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
     :text    => 'Hey #{@driver.name}, you\'re all clear to shred.'}
  end

  def send!
    @mg_client.send_message "clubloose-north.com", message
  end
end
