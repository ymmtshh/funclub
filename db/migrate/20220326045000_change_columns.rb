class ChangeColumns < ActiveRecord::Migration[6.0]
  def change    
    add_column :users, :is_deleted, :boolean, default: false, null: false
    add_column :users, :band, :boolean, default: false, null: false

    add_column :schedules, :schedule_date, :date
    add_column :schedules, :open_time, :time
    add_column :schedules, :start_time, :time
    add_column :discs, :published_date, :date
    add_column :movies, :published_date, :date
  end
end
