class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :introduction
      t.references :prefecture, foreign_key: true
      t.text :web
      t.string :avatar
      t.string :twitter
      t.string :instagram
      t.string :youtube
      t.string :line
      t.string :apple
      t.string :spotify

      t.timestamps
    end
  end
end
