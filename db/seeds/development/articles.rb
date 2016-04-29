# これは FactoryGirl じゃないよ。シードデータだけ
# $ rake db:reset をすると、これは development のデータベースに入る

body =
  "Morning Gloryが４対２でSunflowerに勝利。\n" +
  "２回表、６番渡辺の二塁打から７番山田、８番高橋の連続タイムリーで２点先制。" +
  "９回表、ランナー一二塁で２番田中の二塁打で２点を挙げ、ダメを押しました。\n" +
  "投げては初先発の山本が７回を２失点に抑え、伊藤、中村とつないで逃げ切りました。"

  0.upto(29) do |idx|
    Article.create(
    # 会員記事だと、星が現れる
    title: "Article#{idx+10}",
    body: "blah, blah, blah...",
    released_at: 100.days.ago.advance(days: idx),
    expired_at: nil,
    member_only: false
    )
  end
