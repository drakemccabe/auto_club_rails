class AddSeason < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :year, null: false
      t.date :expires, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
