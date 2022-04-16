class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :video
      t.date :published_date

      t.timestamps
    end
  end
end
