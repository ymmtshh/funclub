class CreateProfileGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_genres do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
