class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class Forbidden < StandardError; end
  class NotFound < StandardError; end

  if Rails.env.production?
    # rescue_from の第１匹数には例外のクラスを指定します
    # withオプションには例外が発生したときに実行するメソッドの名前を指定します
    # たとえば、１２行目ではfindメソッドが例外ActiveRecord::RecordNotFoundを発生させたときに、
    # rescue_404メソッドを実行することを指定しています
    rescue_from Exception, with: :rescue_500
    rescue_from ActionController::RoutingError, with: :rescue_404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
    rescue_from ActionController::ParameterMissing, with: :rescue_400
    # rescue_from の順番に注意してください
    # rescue_from Exception のコードから rescue_from ActiveController::ParameterMissing
    # の部分まで、その順番を「入れ替えるとうまく動きません」（8.5）
  end

  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404



  before_action :set_locale
  private
  def set_locale
  	if %w(ja en).include?(cookies[:locale])
  		I18n.locale = cookies[:locale]
  	end
  end

  def current_member
    # 次のコメントアウトのコードもいけるけど、実際のコードは「遅延初期化という」
    # ||= というのは、@current_member に何か入ってたら、何もしない
    # だからその右側のコードの実行の回数が減る
    # Member.find_by(id: session[:member_id]) if session[:member_id]
    if session[:member_id]
      @current_member ||= Member.find_by(id: session[:member_id])
    end
  end

  # こういうのがいい ヽ(*´ｖ`*)ﾉ
  helper_method :current_member


  def login_required
    raise Forbidden unless current_member
  end

  def rescue_400(exception)
    render "errors/bad_request", status: 400, layout: "error", formats: [:html]
  end

  def rescue_403(exception)
    render "errors/forbidden", status: 403, layout: "error", formats: [:html]
  end

  def rescue_404(exception)
    render "errors/not_found", status: 404, layout: "error", formats: [:html]
  end

  def rescue_500(exception)
    render "errors/internal_server_error", status: 500, layout: "error", formats: [:html]
  end

  # すべてのコントローラはこのクラスから継承されてるから、
  # これで書くコードは全ての作られたコントローラに影響を及ぼす

end
