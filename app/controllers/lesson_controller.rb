class LessonController < ApplicationController


	# この :set_message というのはコールバックの名前
	# これを、プライベートのメソッドと同名のメソッドを作る
	before_action :set_message, only: :step7
									# 配列にもできる。 only: [:step7, :step6]
	# only: の代わりに :except もできる => 「before_action :do_something, except :step1」
	# どんなアクションが行われる前に def set_message って関数が行われる。
	# そして、それは def step7 って関数の前だけ！に行われる





	# あの、今は Lesson の　View ファイルはないから、
	# render text: をやる

	def step1
		# <p> 要素とかの中にではなく、ここで文字列を出すにはこうできる
		render text: "こんにちは、#{params[:name]}さん"
		# 最初は、バーに localhost:3000/lesson/step1/geeb を入力してみる
		# routes.rb を見て。パスは　"lesson/:action(/:name)" になってるから、
		# 最初は lesson のアクションを読み込んで、そして適当に入力した"変数"が
		# 実際に ページに出てくる
	end

	def step2
		# コントローラ名とアクション名が取り出したい？こう書けばいい：
		render text: params[:controller] + "#" + params[:action]
		# localhost:3000/lesson/step2 を入力すると、
		# 名前はは ページに出力される
	end

########################################################

	def step3
		redirect_to action: "step4"
		#redirect_to controller: "top", action: "about"

		# localhost:3000/lesson/step3 を入力すると、
		# step4 が行われます。別の step に redirect をしてもいい
	end

	def step4
		render text: "step4 に移動されました"
	end

########################################################

	def step5
		flash[:notice] = "step6 に移動します"
		redirect_to action: "step6"
	end

	def step6
		# この flash[:notice] は step5 で宣言された
		# flash というのは アクション間で変数のやり取りを行うらしい

		render text: flash[:notice]
		# render text: flash.now[:error] = "リダイレクトの後でなく、直接フラッシュを使うとに、flash.nowを書く"


		# 「アクション ー＞ redirect ー＞ アクション」 だけ
		# 移動してから refresh すると　flash[:notice] が nil(null) になる
	end

########################################################

	def step7
		render text: @message
	end



	# ここからテンプレート (view) を使う
	########################################################
	def step8
		@price = (2000 * 1.05).floor
	end

	def step9
		@price = 1000
		# これは step8 のメソッドを使うんじゃなくて、
		# step8.html.erb を使うことを表す
		# だから、def step8 には @price = ... って書いてあっても、
		# このメソッドのインスタンス変数を使う
		render "step8"
	end

	def step10
		@comment = "<script>alert('この html を実際に使うには、view では <%== %> を書かないといけない');</script>"

		@link = "<strong>ソースは rails に自動的に変換された（html の < や > とかは　&lt; に変換された</strong>"

	end

	def step12
		# このメソッドは書式を使って計算が行われる
		@population = 704414
		@surface = 141.31
	end

	def step13
		@time = Time.now
	end

	def step14
		@population = 127767944
	end

	def step15
		@message = "ごきげんいかが？\nRails の勉強をがんばりましょう。"
	end

	def step18
		@zaiko = 10
	end


	def step19
		@items = {"フライパン" => 2680, "ワイングラス" => 2550,
			 "ペッパーミル" => 4515, "ピーラー" => 945, "カツ丼" => 1100}
	end





	# コールバック
	private
	def set_message
		@message = "出来ました"
	end












end
