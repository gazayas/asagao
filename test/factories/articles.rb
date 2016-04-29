FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "Article#{n}"}
    body "なんたらかんたら"
    released_at 2.weeks.ago
    expired_at 2.weeks.from_now
    # member_only は default で false なので、記述必要はないということです
  end
end
