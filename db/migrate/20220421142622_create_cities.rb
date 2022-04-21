class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities, id: :serial do |t|
      t.integer :prefecture_id
      t.string :name, null: false, limit: 16

      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
    end
  end
end
