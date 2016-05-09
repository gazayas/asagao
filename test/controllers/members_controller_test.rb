require 'test_helper'

class MembersControllerTest < ActionController::TestCase

  def setup
    login_as("taro")
  end

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
    # login_as("taro") # このメソッドは test_helper.rb に入ってます。
    get :index # member#index は会員限定だから
    assert_response :success
  end

  test "index before login" do
    logout
    get :index
    assert_response :forbidden
    # 前はこのテストはこれだけだった：assert_raise(ApplicationController::Forbidden) {get :index}
    # 誰もログインしてないから
  end

  test "create" do
    post :create, member: attrs_with_image("valid.jpg", "image/jpeg")
    member = assigns[:member]
    assert_redirected_to member
    refute_nil member.image
  end

  test "fail to create" do
    post :create, member: attrs_with_image("invalid.jpg", "image/jpeg")
    assert_template "new"
    member = assigns[:member]
    assert member.errors.include?(:"image.uploaded_image")
  end

  private
  def attrs_with_image(fname, type)
    FactoryGirl.attributes_for(:member, image_attributes: {
      uploaded_image: uploaded_file(fname, type) })
  end


end
