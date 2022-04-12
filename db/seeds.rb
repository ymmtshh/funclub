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

Prefecture.create(name: '北海道', slug: 'hokkaido')
Prefecture.create(name: '青森県', slug: 'aomori')
Prefecture.create(name: '秋田県', slug: 'akita')
Prefecture.create(name: '岩手県', slug: 'iwate')
Prefecture.create(name: '宮城県', slug: 'miyagi')
Prefecture.create(name: '山形県', slug: 'yamagata')
Prefecture.create(name: '福島県', slug: 'fukushima')
Prefecture.create(name: '栃木県', slug: 'tochigi')
Prefecture.create(name: '茨城県', slug: 'ibaraki')
Prefecture.create(name: '群馬県', slug: 'gunma')
Prefecture.create(name: '埼玉県', slug: 'saitama')
Prefecture.create(name: '千葉県', slug: 'chiba')
Prefecture.create(name: '東京都', slug: 'tokyo')
Prefecture.create(name: '神奈川県', slug: 'kanagawa')
Prefecture.create(name: '新潟県', slug: 'nigata')
Prefecture.create(name: '富山県', slug: 'toyama')
Prefecture.create(name: '石川県', slug: 'ishikawa')
Prefecture.create(name: '福井県', slug: 'fukui')
Prefecture.create(name: '山梨県', slug: 'yamanashi')
Prefecture.create(name: '長野県', slug: 'nagano')
Prefecture.create(name: '岐阜県', slug: 'gifu')
Prefecture.create(name: '静岡県', slug: 'shizuoka')
Prefecture.create(name: '愛知県', slug: 'aichi')
Prefecture.create(name: '三重県', slug: 'mie')
Prefecture.create(name: '滋賀県', slug: 'shiga')
Prefecture.create(name: '京都府', slug: 'kyoto')
Prefecture.create(name: '大阪府', slug: 'osaka')
Prefecture.create(name: '兵庫県', slug: 'hyougo')
Prefecture.create(name: '奈良県', slug: 'nara')
Prefecture.create(name: '和歌山県', slug: 'wakayama')
Prefecture.create(name: '鳥取県', slug: 'tottori')
Prefecture.create(name: '島根県', slug: 'simane')
Prefecture.create(name: '岡山県', slug: 'okayama')
Prefecture.create(name: '広島県', slug: 'hiroshima')
Prefecture.create(name: '山口県', slug: 'yamaguchi')
Prefecture.create(name: '徳島県', slug: 'tokushima')
Prefecture.create(name: '香川県', slug: 'kagawa')
Prefecture.create(name: '愛媛県', slug: 'ehime')
Prefecture.create(name: '高知県', slug: 'kouchi')
Prefecture.create(name: '福岡県', slug: 'fukuoka')
Prefecture.create(name: '佐賀県', slug: 'saga')
Prefecture.create(name: '長崎県', slug: 'nagasaki')
Prefecture.create(name: '熊本県', slug: 'kumamoto')
Prefecture.create(name: '大分県', slug: 'oita')
Prefecture.create(name: '宮崎県', slug: 'miyazaki')
Prefecture.create(name: '鹿児島県', slug: 'kagoshima')
Prefecture.create(name: '沖縄県', slug: 'okinawa')