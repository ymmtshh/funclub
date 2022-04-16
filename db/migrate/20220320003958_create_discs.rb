class CreateDiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :discs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :price
      t.text :body
      t.string :image
      t.date :published_date

      t.timestamps
    end
  end
end
