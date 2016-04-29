module ApplicationHelper

  # ちょっとややこしいけど、コントローラ？には page_title があれば、それを追加する
  # 入っていなければ、"Morning Glory" だけを出力します
  # 例えば、view の about.html.erb を見たら、<% @page_title="..." %> ってのが view の中で宣言された
  # その変数はこのメソッドに入ってんのかな
  def page_title
    title = "Morning Glory"
    title = @page_title + "-" + title if @page_title
    title # これは title を戻し値として戻す。AAAHHHH RUBY!!!
  end

  def menu_link_to (text, path)
    link_to_unless_current(text, path) {content_tag(:span, text)}
  end

  

end
