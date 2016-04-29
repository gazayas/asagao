# これは元々このフォルダに入ってなかった（ファイル全体は）。フォルダはあったけど
# このメソッドはすべてのテンプレート、つまり View、で使えるようになったと思う




# gsubって javascript の words.replace(/あ/, "い"); に似てるかもしれない。
# 本によると、改行すると、その改行の代わりに <br/> が入るらしい


module LessonHelper

  # これは step15.html.erb で使われる
  def tiny_format(text)
    h(text).gsub(/\n/, "<br/>").html_safe
  end



end
