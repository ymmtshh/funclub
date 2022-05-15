class CreateGoodsCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :goods_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :goods_categories, :name, unique: true
    add_index :goods_categories, :slug, unique: true
  end
end
