# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do |n|
#   @user = User.create!(
#     email: "test#{n + 1}@test.com",
#     username: "test#{n + 1}",
#     password: "password#{n + 1}",
#     confirmed_at: DateTime.now
#   )
# end
# @user.skip_confirmation!
# @user.save

# User.all.each_with_index do |user|
#   @profile = Profile.create!(
#     user_id: user.id,
#     name: user.username, 
#   )
# end
# @profile.save

# CSVファイルを使用することを明示
require 'csv'

# 使用するデータ（CSVファイルの列）を指定
CSVROW_PREFNAME = 6
CSVROW_CITYNAME = 7

# CSVファイルを読み込み、DB（テーブル）へ保存
CSV.foreach('db/csv/prefecture.CSV', encoding: "Shift_JIS:UTF-8") do |row|
  prefecture_name = row[CSVROW_PREFNAME]
  city_name = row[CSVROW_CITYNAME]
  prefecture = Prefecture.find_or_create_by(name: prefecture_name)
  City.find_or_create_by(name: city_name, prefecture_id: prefecture.id)
end