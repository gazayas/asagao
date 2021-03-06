body =
  "今晩は久しぶりに神宮で野球観戦。内野B席の上段に着席。\n" +
  "先発はヤクルト館山、広島福井。" +
  "５回までは０対０の投手戦で、ヤクルトはノーヒット。" +
  "６回に試合が動きだし、２点先行されます。" +
  "しかし、その裏、畠山の満塁弾に宮本のソロで大逆転！\n" +
  "しかし７回に押元が大乱調、栗原に満塁弾をお返しされてしまいました。"

  %w(Taro Jiro Hana).each do |name|
    member = Member.find_by(name: name)
    0.upto(9) do |idx|
      entry = Entry.create(
        author: member,
        title: "野球観戦#{idx}",
        body: body,
        posted_at: 10.days.ago.advance(days: idx),
        status: %w(draft member_only public)[idx % 3]
        )
        # シードデータを投入すると、もう既に投票(vote)されてる記事ができる
        if idx == 7 || idx == 8
          %w(John Mike Sophy).each do |name2|
            voter = Member.find_by(name: name2)
            voter.voted_entries << entry
          end
        end
    end
  end
