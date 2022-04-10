FactoryBot.define do
  factory :profile do
    name  { username }
    association :user
  end
end
