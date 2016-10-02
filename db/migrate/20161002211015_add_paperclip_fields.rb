class AddPaperclipFields < ActiveRecord::Migration[5.0]
  def change
    change_table :listings do |t|
      t.attachment :cover_photo
      t.rename :picture_url, :cover_photo_remote_url 
    end
  end
end
