class Addfronteditor < ActiveRecord::Migration
  def change
      create_table :boxes do |t|
        t.string :subtext
        t.string :title
        t.string :photo
        t.timestamps null: false
      end
  end
end
