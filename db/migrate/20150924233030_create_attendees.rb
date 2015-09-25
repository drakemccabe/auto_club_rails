class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.belongs_to :driver, index: true
      t.belongs_to :event, index: true
      t.timestamps
    end
  end
end
