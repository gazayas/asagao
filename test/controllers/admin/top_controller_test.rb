require 'test_helper'

class Admin::TopControllerTest < ActionController::TestCase

  test "一般会員向けのindex"
    login_as("taro")
    get :index
    assert_template "errors/forbidden"
  end

  test "管理者向けのindex" do
    login_as("jiro", true)
    get :index
    assert_template "admin/top/index"
  end

end
