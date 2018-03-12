class AddEventsRelation < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :season, index: true
  end
end
