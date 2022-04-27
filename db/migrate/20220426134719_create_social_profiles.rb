class CreateSocialProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :social_profiles do |t|
      t.references :profile, null: false, foreign_key: true
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
