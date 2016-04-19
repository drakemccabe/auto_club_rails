class Driver < ActiveRecord::Base
  has_many :attendees
  has_many :events, :through => :attendees

  validates :name, presence: true
  validates :car, presence: true

  #To do
  # validates payment fields for inclusion
end
