class ChangecolumnToProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :location
    add_reference :profiles, :prefecture, null: false, foreign_key: true
  end
end
