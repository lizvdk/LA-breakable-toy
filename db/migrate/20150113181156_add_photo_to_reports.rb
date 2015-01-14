class AddPhotoToReports < ActiveRecord::Migration
  def change
    add_column :reports, :photo, :string
  end
end
