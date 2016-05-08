require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # 空の値のチェック
  test "presence" do
    article = Article.new
    # article は空なので invalid ってこと
    # だからエラーメッセージの作られ、次の行でメッセージが include されているということを確認します。
    assert article.invalid?
    assert article.errors.include?(:title)
    assert article.errors.include?(:body)
    assert article.errors.include?(:released_at)
  end

  # 長さのチェック。２００字以上だとダメだってことをテストします。
  # models の article.rb でバリデーションを確認してください。
  test "length" do
    article = FactoryGirl.build(:article)
    article.title = "A" * 201
    assert article.invalid?
    assert article.errors.include?(:title)
  end

  # 掲載終了日時は掲載開始日時より後
  test "expired_at" do
    article = FactoryGirl.build(:article)
    article.released_at = Time.current
    article.expired_at = 1.days.ago
    assert article.invalid?
    assert article.errors.include?(:expired_at)
  end


  # no_expiration がオンなら expired_at を使わない
  test "no_expiration" do
    article = FactoryGirl.build(:article)
    article.no_expiration = true
    assert article.valid?
    assert_nil article.expired_at
  end

  # モデルで加えた open スコープのチェック
  test "open" do
    article1 = FactoryGirl.create(:article, title: "現在",
                released_at: 1.day.ago, expired_at: 1.day.from_now)
    article2 = FactoryGirl.create(:article, title: "過去",
                released_at: 2.days.ago, expired_at: 1.day.ago)
    article3 = FactoryGirl.create(:article, title: "未来",
                released_at: 1.day.from_now, expired_at: 2.days.from_now)
    article4 = FactoryGirl.create(:article, title: "終了日なし",
                released_at: 1.day.ago, expired_at: nil)

    # こうやって Article.rb にある open というスコープ（無名関数）を使う
    # open という関数は、時間的には現在の記事だけを取り出す。article2 と article3 はダメですね。
    # articles という変数に open というスコープを代入して、それを assert や refute文で実際に使う
    # 「openメソッドが返すリレーションオブジェクトは、配列と同じように扱えるので、assert_includes
    # とrefute_includesでチェックできます」
    articles = Article.open
    assert_includes articles, article1, "現在の記事が含まれる"
    refute_includes articles, article2, "過去の記事は含まれない"
    refute_includes articles, article3, "未来の記事は含まれない"
    assert_includes articles, article4, "expiredがnilの場合"
  end

=begin
　# readable_for スコープのチェック
  test "readable_for" do
    article1 = FactoryGirl.create(:article)
    article2 = FactoryGirl.create(:article, member_only: true)
    articles = Article.readable_for(nil)
    assert_includes articles, article1, "現在の記事が含まれる"
    refute_includes articles, article2, "会員限定記事は含まれない"

    articles = Article.readable_for(FactoryGirl.create(:member))
    assert_includes articles, article1, "現在の記事が含まれる"
    assert_includes articles, article2, "会員限定記事が含まれる"
  end
=end



end
