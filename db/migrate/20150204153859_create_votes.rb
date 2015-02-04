class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :report_id, null: false

      t.timestamps null: false
    end

    add_index :votes, [:report_id, :user_id], unique: true
  end
end
