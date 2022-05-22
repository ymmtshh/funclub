class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.string :reserve_content

      t.timestamps
    end
  end
end
