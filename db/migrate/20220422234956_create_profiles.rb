class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
        t.references :user, null: false, foreign_key: true
        t.string :name
        t.text :introduction
        t.integer :prefecture_id
        t.text :web
        t.string :avatar
  
        t.timestamps
    end
  end
end
