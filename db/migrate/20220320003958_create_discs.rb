class CreateDiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :discs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :release
      t.string :price
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end