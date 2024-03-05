FactoryBot.define do
  factory :user do
    nickname { 'test' }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    family_name { '山田' }
    first_name { '太郎' }
    kana_family_name { 'ヤマダ' }
    kana_first_name { 'タロウ' }
    birthday { Date.today }
  end
end
