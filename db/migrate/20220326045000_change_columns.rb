class ChangeColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :location, :string
    add_column :profiles, :location, :integer
    add_column :profiles, :twitter, :string
    add_column :profiles, :instagram, :string
    add_column :profiles, :youtube, :string
    add_column :profiles, :line, :string
    add_column :profiles, :apple, :string
    add_column :profiles, :spotify, :string
    
    add_column :users, :is_deleted, :boolean, default: false, null: false
    add_column :users, :role, :integer, default: 0, null: false
  end
end
