names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]

0.upto(29) do |idx|
  Member.create(
    number: idx + 20,
    name: "John#{idx + 1}",
    full_name: "John Doe#{idx + 1}",
    email: "John#{idx + 1}@example.com",
    birthday: "1981-12-01",
    gender: 0,
    administrator: false,
    password: "password",
    password_confirmation: "password"
  )
end
