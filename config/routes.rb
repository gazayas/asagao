Rails.application.routes.draw do

   root 'top#index'

   # 新しい http のメソッドを作る。コントローラに def about ~ end
   # を作って、views で about.html.erb を作るだけだ
   # as: ってやつは、コントローラや view の中で about_path みたいな
   # コードを入れたら、"/about" って文字列が返されるらしい
   get "about" => "top#about", as: "about"

   get "bad_request" => "top#bad_request"
   get "internal_server_error" => "top#internal_server_error"

   # get "パス" => "コントローラ名#アクション名"
   # get は http のメソッド
   # 「ルーティングにはasオプションで名前を付けることができます。」

   # 引数をパス（バーで現れる URL）で表示したい時は、こう書く：
   # get "articles/:year/:month" => "articles#show"

   get "lesson/:action(/:name)" => "lesson"


   # $ rails g controller members を行ったのでこれを追加する
   resources :members do
      # これは検索の機能を加える
      collection {get "search"}
   end

   # 第７章７.３で追加されました
   resources :articles

   # 8.2 で追加した
   # resource と session は単数系のことを気をつけてください
   # でも、コントローラは sessions となってる
   resource :session, only: [:create, :destroy]
   # resource :account, only: [:show, :edit, :update]
   resource :account
   match "*anything" => "top#not_found", via: [:get, :post, :patch, :delete]
   # これは、「設定されていないパスはすべてTopControllerのnot_foundアクションの呼び出しにする」
   # というものです。

   # 6.4 の最後の部分を参考にしてください（日本語以外の言語に対応するには）
   get "locale" => "top#locale", as: "locale"







end