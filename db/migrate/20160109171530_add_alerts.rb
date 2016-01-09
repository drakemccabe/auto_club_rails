class AddAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :body
      t.date :exp_date
      t.timestamps null: false
    end
  end
end
