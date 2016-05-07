class Entry < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  # この２つがないと、Railsはentriesテーブルにauthor_idというカラムがあり、
  # Authorという名前のモデルを参照しているのだと誤解してしまいます。

end
