# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  @user = User.create!(
    email: "test#{n + 1}@test.com",
    username: "test#{n + 1}",
    password: "password#{n + 1}",
    confirmed_at: DateTime.now
  )
end
@user.skip_confirmation!
@user.save

User.all.each_with_index do |user|
  @profile = Profile.create!(
    user_id: user.id,
    name: user.username, 
  )
end
@profile.save
