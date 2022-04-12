class ChangecolumnToPrefectures < ActiveRecord::Migration[6.0]
  def change
    add_column :prefectures, :slug, :string, null: false
    add_index :prefectures, :slug, unique: true
  end
end
