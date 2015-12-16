class Event < ActiveRecord::Base
  has_many :attendees
  has_many :drivers, :through => :attendees

  validates :name, presence: true
  validates :price, presence: true
  validates :date, presence: true, uniqueness: true
  validates :location, presence: true

  def is_bundle?
    date_check.present?
  end

  def date_check
    matches = []
    Event.where.not(date: self.date).each do |entry|
      if entry.date == self.date + 1 || entry.date == self.date - 1
        matches << entry
      end
    end
    if matches.empty?
      matches = nil
    else
      matches.unshift(self)
    end
  end
end
