class ChengecolumnToPrefectures < ActiveRecord::Migration[6.0]
  def change
    add_index :prefectures, :slug, unique: true
  end
end
