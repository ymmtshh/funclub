class CreatePrefectures < ActiveRecord::Migration[6.0]
  def change
    create_table :prefectures, id: :serial do |t|
      t.string :name, null: false, limit: 4

      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
    end
  end
end
