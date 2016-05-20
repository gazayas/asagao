require 'test_helper'
require 'integration_test_helper'

class ManageArticlesTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelper #これも追加した

  # 記事の新規作成ページにアクセスする、createアクションを失敗させる、
  # createアクションを成功させて記事の詳細ページをチェックする、
  # というものです。

  test "article を追加します" do
    login_as("taro", true)
    get "admin/articles/new"
    assert_response :success

    post "/admin/articles", article: FactoryGirl.attributes_for(:article, title: "")
    assert_template "new"
    assert_select "h3", "エラーがあります。"

    post "/admin/articles",
    article: FactoryGirl.attributes_for(:article, title: "テスト記事")
    assert_redirected_to [:admin, assigns[:article]]
    follow_redirect!
    assert_select "h1", "テスト記事"
  end

end
