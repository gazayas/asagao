names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]

0.upto(9) do |idx|
  member = Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: "1981-12-01",
    gender: [0, 0, 1][idx % 3],
    administrator: (idx == 0),
    password: "password",
    password_confirmation: "password"
  )
  # 次の行でこのフォルダにある画像を呼び出す
  path = Rails.root.join("db/seeds/development", "member#{idx % 3 + 1}.jpg")
  file = Rack::Test::UploadedFile.new(path, "image/jpeg", true)
  MemberImage.create(
    member: member,
    uploaded_image: file
  )
end
