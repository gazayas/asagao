require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  # "the truth" というのが名前に過ぎない。自分が何をテストしたいかを決めて、それでテストの名前を決めます。
  test "the truth" do
    assert true
  end


  test "factory girl" do
    member = FactoryGirl.create(:member)
    p member # memberを説明する（ターミナルで表示される）
    assert_equal "Yamada Taro", member.full_name
    # 前の行は "Yamada Taro" と member.full_name が同じ値だったら、true を返します。
  end

  test "authenticate" do
    # Memberモデルのクラスメソッドauthenticateは、
    # その名前とパスワードを持つ会員がいれば、その会員のMemberオブジェクトを
    # 返すことにします

    # このテストは、間違えたパスワードは authenticate のメソッドを通らないことを確認します
    # そして、taro, happy が上手く通れたかを確認するために assert_equal を
    member = FactoryGirl.create(:member, name: "taro",
              password: "happy", password_confirmation: "happy")
    assert_nil Member.authenticate("taro", "lucky")
    assert_equal member, Member.authenticate("taro", "happy")
  end

end
