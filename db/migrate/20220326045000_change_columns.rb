class ChangeColumns < ActiveRecord::Migration[6.0]
  def change    
    add_column :users, :is_deleted, :boolean, default: false, null: false
    add_column :users, :band, :boolean, default: false, null: false

    add_column :schedules, :schedule_date, :datetime
  end
end
