class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.bigint :status, default: 0
      t.string :name
      t.string :number
      t.string :body

      t.timestamps
    end
  end
end
