FactoryBot.define do
  factory :user do
    name { 'Yamada Tarou' }
    profile_text { 'よろしく！' }
    sequence(:email) { |n| "yamade#{n}@rails.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
