require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Asagao
  class Application < Rails::Application

    config.time_zone = 'Tokyo'


    # 次の行はコメントアウトされてて、 :ja の代わりに :de があった（デフォルト？）
    config.i18n.default_locale = :ja
    # ところで、i18n は「国際化」、「Internationalization」という意味


    config.active_record.raise_in_transactional_callbacks = true

    # 次のを教科書の 6.2 で追加した。現在は strong parameters だけど次の行はそれをバイパスする
    # 上のコメントはあった。前は、permit_all_parameters = true だったけど、
    # strong parameters をまた有効にする。
    # ってことは、false にする
    config.action_controller.permit_all_parameters = false


    #7.2 で加えたコードです。今回はSQLを使ってないと思うので要らないかな
    config.active_record.schema_format = :sql


  end
end
