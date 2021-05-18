FactoryBot.define do
  factory :post do
    user_id { 1 }
    introduction_title {"はじめに"}
    introduction_text {"こんなにひどかったニキビあら不思議！"}
    introduction? { true }
    user
  end
end
