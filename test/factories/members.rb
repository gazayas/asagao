# これはテストではなくて、テストようのデータを作るためのコードです
# sequence を使うと、for文みたいに、n は 0 から始まって何回かブロックが行われる
# member の number とかは重複されるのはダメなのでこうやってます
FactoryGirl.define do
  factory :member do
    sequence(:number) {|n| n + 1}
    sequence(:name) {|n| "Taro#{n}"}
    full_name "Yamada Taro"
    sequence(:email) {|n| "taro#{n}@example.com"}
    birthday 30.years.ago
    password "password"
    password_confirmation "password"
  end
end
