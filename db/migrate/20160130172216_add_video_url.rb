class AddVideoUrl < ActiveRecord::Migration
  def change
    add_column :boxes, :video_url, :string
    add_column :boxes, :footer_image, :string
  end
end
