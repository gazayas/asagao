#改訂3版基礎 Ruby on Rails <br> 著者：黒田努・佐藤和人

Asagao (Morning Glory) というモックアプリを作りながら、<br>
ror のアプリの作り方を勉強するための教科書です。

合計で９章５節があって９章１節まで読んでみました。

ところどころにコメントを書いたので<br>
短い解説も参照にしてください

##残っている学習項目： <br>
1. モデルの関連付けの実装 <br>
2. 会員画像の扱い方 <br>
3. 「いいね」ボタンの作成 <br>
4. 管理ページの作成 <br>

##問題
そんなに大きな問題じゃないけど、<br>
エラーページのテストを実装して行おうとした際、<br>
factory_girl の調子が悪くなってしまい、<br>
`variable = FactoryGirl.create(:member)` みたいなコードを記述すると上手く代入されず、<br>
variable は uninitialized constant になってしまうバッグが発生してしまいました。

エラーページのテストを実装する前に、<br>
factory_girl のコードには問題は全然なく、<br>
test_helper.rb の login_as(member) というメソッドも上手く処理されていましたが、<br>
現在は動けないから解決する方法を工夫

##その他
1. ページネーションを使うには`will_paginate`があったけど、<br>
<a href="https://github.com/amatsuda/kaminari" target="_blank">kaminari</a> もあります。
2. `factory_girl_rails` の他に <a href="http://www.fabricationgem.org/" target="_blank">Fabrication</a> もあります
