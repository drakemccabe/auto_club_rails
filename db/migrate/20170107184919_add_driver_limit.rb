class AddDriverLimit < ActiveRecord::Migration
  def change
    add_column :events, :driver_limit, :integer
  end
end
