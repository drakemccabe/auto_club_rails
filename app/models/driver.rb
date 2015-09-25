class Driver < ActiveRecord::Base
  has_many :attendees
  has_many :events, :through => :attendees

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :car, presence: true
end
