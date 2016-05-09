class MembersController < ApplicationController

  before_action :login_required

  # これは七つのアクションに入ってないけど追加した
  def search
    @members = Member.search(params[:q]).paginate(page: params[:page], per_page: 15)
    # :q というのは検索のワードらしい (query かもしれない)
    render "index"
  end

   def index
     # これはクエリメソッドです。SQLの文を書いてレコードが取り出せる
     # index では SQL 文を使って取り出せばいいかな、普通は
     @members = Member.order("number").paginate(page: params[:page], per_page: 15)
   end

   def show
    @member = Member.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "show"
    end
   end

   def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
    # 予めに、誕生日の原点を置いとく (Date.new(1980, 1, 1) の部分)
    # 普通は @member = Member.new かもしれない

    @member.build_image # 9.3 で追加した
   end

   # 会員の新規登録
   def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: "会員を登録しました。"
    else
      render "new"
    end
   end

   def edit
    @member = Member.find(params[:id])
    @member.build_image unless @member.image # 9.3 で追加した
   end

   def update
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to @member, notice: "会員情報を更新しました。"
    else
      render "edit"
    end
   end

   def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :members, notice: "会員を削除しました。"
   end

   private
   def member_params
     attrs = [:number, :name, :full_name, :gender, :birthday, :email, :password, :password_confirmation]
     # 管理者だけが管理者の情報を edit で編集できるように：
     attrs << :administrator if current_member.administrator?
     attrs << {image_attributes: [:_destroy, :id, :uploaded_image]} # 9.3 で追加した
       params.require(:member).permit(attrs)
   end

   def send_image
     if @member.image.present?
       # バイナリーデータを送信するときは、renderメソッドの代わりにsend_dataメソッドを使います。
       send_data @member.image.data,
       type: @member.image.content_type, disposition: "inline"
       # disposition: "inline" というのは、ブラウザーがダウンロード画面を表示しないためらしい
     else
       raise NotFound
     end
   end

end
