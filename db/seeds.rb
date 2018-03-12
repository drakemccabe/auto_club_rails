# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
User.create(email: "example@example.com", password: "password")

Box.create(subtext: "CLUBLOOSE NORTH 2015", title: "THANKS FOR ANOTHER INCREDIBLE SEASON.", photo: "", video_url: "https://player.vimeo.com/video/153273292", footer_image: "https://scontent-lga3-1.xx.fbcdn.net/hphotos-xlf1/t31.0-8/12471366_10201447120575388_2888757661283813519_o.jpg")

def create_event(date)
  return Event.create(name: "Seed Event", date: date, price: 90, location: "NHMS", facebook_url: "https://www.facebook.com/groups/clubloosenorth/", photo_url: "//s3.amazonaws.com/clubloosenorth/cln/images/event1.jpg" )
end

create_event(Date.today - 1000.days)
create_event(Date.today - 365.days)

season = [
  create_event(Date.today - 1000.days),
  create_event(Date.today - 10.days),
  create_event(Date.today - 11.days),
  create_event(Date.today),
  create_event(Date.today + 1.days),
  create_event(Date.today + 4.days),
  create_event(Date.today + 5.days),
  create_event(Date.today + 10.days),
  create_event(Date.today + 11.days),
  create_event(Date.today + 16.days),
  create_event(Date.today + 28.days),
  create_event(Date.today + 29.days)
]

bundle = Season.create(name: "Clubloose North Season Pass", description: "Get your season pass", expires: Date.new(2018, 12, 01), price: 1530, year: 2018)
season.each do |s|
  bundle.events << s
end
bundle.save
