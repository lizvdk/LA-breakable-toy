class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :description
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
