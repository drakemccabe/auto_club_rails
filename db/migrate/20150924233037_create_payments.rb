class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :correlation_id, null: false
      t.integer :event1
      t.integer :event2
      t.integer :price, null: false
      t.string  :first_name
      t.string  :last_name
      t.string  :car
      t.string  :note
      t.string  :item_name
      t.string  :email
      t.boolean :payment_status, null: false
    end
  end
end
