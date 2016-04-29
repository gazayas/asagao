require 'test_helper'

class TopControllerTest < ActionController::TestCase

  test "index" do
    2.times {FactoryGirl.create(:article)}
    FactoryGirl.create(:article, released_at: 1.hours.from_now)
    get :index
    assert_response :success
    assert_select "div#content h2", 2
    # 三つの記事を作ったけど、モデルの article.rb で作られた「open」というスコープのために、
    # 二つしか出てこない筈だ（三つ目の記事は将来の記事で現在のページに出てくる筈はないということだ）。
    # だから、assert_select は、<div id="content"></div> の中に二つの <h2> しかない
    # ということを確認します。
    # 二つの div class="content" というやつがあることをテストします。（class か id か？）
  end

end
