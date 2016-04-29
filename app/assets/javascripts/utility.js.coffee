$(document).on "ready page:load", ->
  change_expired_at = ->
    if $("#article_no_expiration").prop("checked")
      $("#article_expired_at").hide()
    else
      $("#article_expired_at").show()

  $("#article_no_expiration").bind("click", change_expired_at)
  change_expired_at()

# このスクリプトでは、フォームの「掲載終了日時」がチェックされると、
# 日時の<select>が現れ、チェックされないと、そのセレクトは隠される。
# 実際に動けるように、articles/_form.html.erb に
# <div id="article_expired_at"> を入れないといけない
