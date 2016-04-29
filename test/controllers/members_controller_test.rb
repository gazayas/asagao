require 'test_helper'

class MembersControllerTest < ActionController::TestCase


  test "the truth" do
    a = 1
    #  もし「a」が１でない場合は、次の行はターミナルの中でエラーメッセージを表示する
    assert a == 1, "\naは1ではありません"
  end

  # テストの名前なんですけど、これは自分が
  test "矛盾" do
    # 1 != 2 なのでこれは成功する
    # assert_equal 1, 2 だったら失敗する
    refute_equal 1, 2
  end

  test "index" do
    login_as("taro") # このメソッドは test_helper.rb に入ってます。
    get :index # member#index は会員限定だから
    assert_response :success
  end

  test "index before login" do
    get :index
    assert_response :forbidden
    # 前はこのテストはこれだけだった：assert_raise(ApplicationController::Forbidden) {get :index}
    # 誰もログインしてないから
  end


end
