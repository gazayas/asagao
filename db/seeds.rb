# このコードは、db/seeds/development フォルダの下に「テーブル名.rb」があれば、
# それをrequireメソッドで実行するものです。
# 本番モードでは db/seeds/productionフォルダの下のファイルを実行します。

table_names = %w(members articles)

table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end
