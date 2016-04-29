class TopController < ApplicationController

  #layout "testLayout" # app/views/layouts を使う
                      # これなしで、デフォルトの application.html.erb が使われる

  def index
    @articles = Article.open.readable_for(current_member).order(released_at: :desc).limit(5)
  end

  def about
  end

  # routes.rb に locale のやつを書いたのでそれも見てください
  def locale
  	if %w(ja en).include?(params[:locale])
  		cookies[:locale] = params[:locale]
  		redirect_to :root
  	end
  end

  def not_found
    raise ActionController::RoutingError,
      "No route mateches #{request.path.inspect}"
  end

  def bad_request
    raise ActionController::ParameterMissing, ""
  end

  def internal_server_error
    raise Exception
  end

end
