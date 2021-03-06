require 'test_helper'

class Admin::ArticlesControllerTest < ActionController::TestCase
  def setup
    login_as("taro", true)
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "new before login" do
    logout
    get :new
    assert_response :forbidden
    # assert_raise(ApplicationController::Forbidden) {get :new}
  end

  test "edit" do
    article = FactoryGirl.create(:article)
    get :edit, id: article
    assert_response :success
  end

  test "create" do
    post :create, article: FactoryGirl.attributes_for(:article)
    article = Article.order(:id).last
    assert_redirected_to [:admin, article]
  end

  test "update" do
    article = FactoryGirl.create(:article)
    patch :update, id: article, article: FactoryGirl.attributes_for(:article)
    assert_redirected_to [:admin, article]
  end

  # レコードの保存が失敗した時のテスト
  # でもこの部分はよく分からない...
  test "fail to create" do
    attrs = FactoryGirl.attributes_for(:article, title: "")
    post :create, article: attrs # 第２引数はフォームの内容。前行のattributes_for はフォームの内容を設定する。
    assert_response :success # 多分 post :create が上手く送信されたので :success を assert するけど、失敗するので new が出てる。
    assert_template "new" # そういう訳で assert_template "new" となる。
  end

  test "fail to update" do
    attrs = FactoryGirl.attributes_for(:article, body: "")
    article = FactoryGirl.create(:article)
    put :update, id: article, article: attrs
    assert_response :success
    assert_template "edit"
  end

=begin
"fail to create" と "fail to update" について：
「FactoryGirl.attributes_forでフォームの内容を作成し、
createアクションではタイトル、updateアクションでは本文を空にします。
HTTPリクエストの結果は、リダイレクトではなく「assert_response :success」となります。
また、assert_templateで適切なテンプレートが選ばれているかおチェックします。
=end

  test "destroy" do
    article = FactoryGirl.create(:article)
    delete :destroy, id: article
    assert_redirected_to :admin_articles
    assert_raises(ActiveRecord::RecordNotFound) {
      Article.find(article.id) # 記事が本当に削除されたかどうかを確認する。すごい。
    }
  end

end
