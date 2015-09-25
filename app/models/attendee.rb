class Attendee < ActiveRecord::Base
  belongs_to :driver
  belongs_to :event
end
