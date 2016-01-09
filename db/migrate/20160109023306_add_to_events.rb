class AddToEvents < ActiveRecord::Migration
  def change
    add_column :events, :facebook_url, :string
    add_column :events, :photo_url, :string
  end
end
