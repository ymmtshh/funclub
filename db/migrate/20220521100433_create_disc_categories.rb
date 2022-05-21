class CreateDiscCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :disc_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :disc_categories, :name, unique: true
    add_index :disc_categories, :slug, unique: true
  end
end
