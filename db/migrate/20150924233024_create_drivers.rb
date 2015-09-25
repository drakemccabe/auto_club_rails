class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :car, null: false
      t.string :note
      t.timestamps
    end
  end
end
