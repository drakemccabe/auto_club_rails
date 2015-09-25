class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.integer :price, null: false
      t.string :location, null: false
      t.timestamps
      t.index :date, unique: true
    end
  end
end
