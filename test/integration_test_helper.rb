# これは前からではなくて、教科書の指示でこれを作った（8.2 の最後らへん）

module IntegrationTestHelper
  private
  # ログイン状態にする
  def login_as(name, admin = false)
    member = FactoryGirl.create(:member, name: name, administrator: admin)
    post "/session", name: member.name, password: "password"
  end

  # ログアウト状態にする
  def logout
    delete "/session"
  end

end
