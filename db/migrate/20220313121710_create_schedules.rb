class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.date :schedule_date
      t.time :open_time
      t.time :start_time
      t.string :image
      
      t.timestamps
    end
  end
end
