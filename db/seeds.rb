# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# # CSVファイルを使用することを明示
# require 'csv'
# # 使用するデータ（CSVファイルの列）を指定
# CSVROW_PREFNAME = 6
# CSVROW_CITYNAME = 7
# # CSVファイルを読み込み、DB（テーブル）へ保存
# CSV.foreach('db/csv/prefecture.CSV', encoding: "Shift_JIS:UTF-8") do |row|
#   prefecture_name = row[CSVROW_PREFNAME]
#   city_name = row[CSVROW_CITYNAME]
#   prefecture = Prefecture.find_or_create_by(name: prefecture_name)
#   City.find_or_create_by(name: city_name, prefecture_id: prefecture.id)
# end

Prefecture.create([
  { name: '北海道', slug: 'hokkaido' },
  { name: '青森県', slug: 'aomori' },
  { name: '秋田県', slug: 'akita' },
  { name: '岩手県', slug: 'iwate' },
  { name: '宮城県', slug: 'miyagi' },
  { name: '山形県', slug: 'yamagata' },
  { name: '福島県', slug: 'fukushima' },
  { name: '栃木県', slug: 'tochigi' },
  { name: '茨城県', slug: 'ibaraki' },
  { name: '群馬県', slug: 'gunma' },
  { name: '埼玉県', slug: 'saitama' },
  { name: '千葉県', slug: 'chiba' },
  { name: '東京都', slug: 'tokyo' },
  { name: '神奈川県', slug: 'kanagawa' },
  { name: '新潟県', slug: 'nigata' },
  { name: '富山県', slug: 'toyama' },
  { name: '石川県', slug: 'ishikawa' },
  { name: '福井県', slug: 'fukui' },
  { name: '山梨県', slug: 'yamanashi' },
  { name: '長野県', slug: 'nagano' },
  { name: '岐阜県', slug: 'gifu' },
  { name: '静岡県', slug: 'shizuoka' },
  { name: '愛知県', slug: 'aichi' },
  { name: '三重県', slug: 'mie' },
  { name: '滋賀県', slug: 'shiga' },
  { name: '京都府', slug: 'kyoto' },
  { name: '大阪府', slug: 'osaka' },
  { name: '兵庫県', slug: 'hyougo' },
  { name: '奈良県', slug: 'nara' },
  { name: '和歌山県', slug: 'wakayama' },
  { name: '鳥取県', slug: 'tottori' },
  { name: '島根県', slug: 'simane' },
  { name: '岡山県', slug: 'okayama' },
  { name: '広島県', slug: 'hiroshima' },
  { name: '山口県', slug: 'yamaguchi' },
  { name: '徳島県', slug: 'tokushima' },
  { name: '香川県', slug: 'kagawa' },
  { name: '愛媛県', slug: 'ehime' },
  { name: '高知県', slug: 'kouchi' },
  { name: '福岡県', slug: 'fukuoka' },
  { name: '佐賀県', slug: 'saga' },
  { name: '長崎県', slug: 'nagasaki' },
  { name: '熊本県', slug: 'kumamoto' },
  { name: '大分県', slug: 'oita' },
  { name: '宮崎県', slug: 'miyazaki' },
  { name: '鹿児島県', slug: 'kagoshima' },
  { name: '沖縄県', slug: 'okinawa' }  
])

Genre.create([
  { name: 'アカペラ', slug: 'acappella' },
  { name: 'アシッドジャズ', slug: 'acid_jazz' },
  { name: 'アンビエント', slug: 'ambient' },
  { name: 'インストゥメンタル', slug: 'instrumental' },
  { name: 'エレクトロポップ', slug: 'electro_pop' },
  { name: 'エモ', slug: 'emo' },
  { name: 'オルタナティヴロック', slug: 'alternative' },
  { name: 'ガレージロック', slug: 'garage' },
  { name: 'カントリー', slug: 'country' },
  { name: 'グランジ', slug: 'grunge' },
  { name: 'サイケデリックロック', slug: 'psychedelic' },
  { name: 'シティポップ', slug: 'city_pop' },
  { name: 'ジャズ', slug: 'jazz' },
  { name: 'シューゲイザー', slug: 'shoegazer' },
  { name: 'シンセポップ', slug: 'synth_pop' },
  { name: 'スカ', slug: 'ska' },
  { name: 'スクリーモ', slug: 'screamo' },
  { name: 'スラッシュメタル', slug: 'thrash_metal' },
  { name: 'ソウル', slug: 'soul' },
  { name: 'ダブステップ', slug: 'dubstep' },
  { name: 'チルウェイヴ', slug: 'chillwave' },
  { name: 'ディスコ', slug: 'disco' },
  { name: 'テクノ', slug: 'techno' },
  { name: 'テクノポップ', slug: 'techno_pop' },
  { name: 'トラップ', slug: 'trap' },
  { name: 'ドラムンベース', slug: 'drum_n_bass' },
  { name: 'トランス', slug: 'trance' },
  { name: 'ドリームポップ', slug: 'dream_pop },' },
  { name: 'ニューウェイヴ', slug: 'newwave' },
  { name: 'ニューエイジ', slug: 'newage' },
  { name: 'ハウス', slug: 'house' },
  { name: 'ハードコア', slug: 'hardcore' },
  { name: 'ハードロック', slug: 'hard_rock' },
  { name: 'パワーポップ', slug: 'power_pop' },
  { name: 'パンクロック', slug: 'punk' },
  { name: 'ヒップホップ', slug: 'hiphop' },
  { name: 'ファンク', slug: 'funk' },
  { name: 'フォーク', slug: 'folk' },
  { name: 'フォークロック', slug: 'folk_rock' },
  { name: 'フュージョン', slug: 'fusion' },
  { name: 'ブルース', slug: 'blues' },
  { name: 'プログレッシブメタル', slug: 'progressive_metal' },
  { name: 'プログレッシブロック', slug: 'progressive_rock' },
  { name: 'ヘヴィメタル', slug: 'heavy_metal' },
  { name: 'ボサノヴァ', slug: 'bossanova' },
  { name: 'メロコア', slug: 'melodious_hardcore' },
  { name: 'ミクスチャーロック', slug: 'mixture_rock' },
  { name: 'ユーロビート', slug: 'eurobeat' },
  { name: 'ラウドロック', slug: 'loud_rock' },
  { name: 'R&B', slug: 'rhythm_and_blues' },
  { name: 'レゲエ', slug: 'reggae' },
  { name: 'レゲトン', slug: 'reggaeton' },
  { name: 'ロカビリー', slug: 'rockabilly' }
])

GoodsCategory.create([
  { name: 'Tシャツ/ロングTシャツ', slug: 'shirt' },
  { name: 'パーカー/スウェット', slug: 'parka_sweatshirt' },
  { name: 'タオル', slug: 'towel' },
  { name: 'バッグ', slug: 'bag' },
  { name: 'その他', slug: 'others' }
])