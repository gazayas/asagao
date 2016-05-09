#改訂3版基礎 Ruby on Rails <br> 著者：黒田努・佐藤和人

Asagao (Morning Glory) というモックアプリを作りながら、<br>
ror のアプリの作り方を勉強するための教科書です。

全部で９章５節があって９章１節まで読んでみました。

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
現在は動けないから解決する方法を工夫<br/><br/>

後は、9.2 で $ rake db:seed をしようとしたら、ダメだった<br/>
なぜかというと、この章では %w(Taro Hana Daredare).each do |name|<br/>
みたいな感じでMember.find_by(name: name) をしようとしていたけど、<br/>
前の章ではarticlesのモデルを作って、memberのシードデータをJohnに変えたわけです(-____-)<br/>
ややこしいですね。それなのに、またTaroさんとかHanaさんとかで名前を取得しようとしてる。<br/>
4.3 のシードデータに戻した<br/>
これを、9.3 のシードデータの「投入」というところで確認できます。<br/>
前は `0.upto(29) do |idx|` だったけど、また `upto(9)` に戻っています

なぜか分からないけど、モデルのarticle_test.rbの最後のテストが上手くいけないからコメントアウトした<br/>
そのコードは 8.2 の「会員限定のコンテンツ」というところに記載してあります。<br/>

9.3 でエラーが出るけど、翻訳はないと言ってしまう（画像のファイルの形式が違う時）<br/>
今はyamlをいじりたくない。。。


##その他
1. ページネーションを使うには`will_paginate`があったけど、<br>
<a href="https://github.com/amatsuda/kaminari" target="_blank">kaminari</a> もあります。
2. `factory_girl_rails` の他に <a href="http://www.fabricationgem.org/" target="_blank">Fabrication</a> もあります
