class AddSeasonRelation < ActiveRecord::Migration[5.0]
  def change
    add_reference :attendees, :season, index: true
  end
end
