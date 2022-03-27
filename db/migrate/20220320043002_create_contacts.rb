class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: true
      t.integer :subject, default: 0, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
