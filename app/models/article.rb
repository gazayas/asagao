class Article < ActiveRecord::Base
  validates :title, :body, :released_at, presence: true
  validates :title, length: {maximum: 200}
  validate :check_expired_at # これはモデルの属性ではない。ただ、この条件を確かめたい。

  # これはコールバックの一つ
  # 後は after_validation, before_save, before_create 等があります
  # before_validation :do_something, on: :create みたいなことができるらしい
  before_validation :clear_expired_at

  scope :open, -> {
    now = Time.current
    where("released_at <= ? AND (? < expired_at OR " +
    "expired_at IS NULL)", now, now)
  }
  scope :readable_for, ->(member) {
    member ? all : where(member_only: false)
  }
  # スコープが返す式はリレーションオブジェクトである必要があります。
  # 引数memberがあれば、モデルのクラスメソッドallを使って
  # 何も条件を加えないリレーションオブジェクトを返します...
  # 引数がなければ、where(member_only: false)によって会員限定でない記事を取り出します。



  def no_expiration
    expired_at.blank?
  end

  # この =(val) のメソッドは setter です。
  # http://stackoverflow.com/questions/5398919/what-does-the-equal-symbol-do-when-put-after-the-method-name-in-a-method-d
  def no_expiration=(val)
    # val が true, 1 か "1" だったら、@no_expiration に true が代入される。そうでない場合は、false が格納される。
    @no_expiration = val.in?([true, 1, "1"])
  end


# これを部分テンプレートの shared/_sidebar.html.erb で使う
# (num=5)。引数をもらって実際に使う
class << self
  def sidebar_articles(member, num=5)
    open.readable_for(member).order(released_at: :desc).limit(num)
  end
end



  private
  def check_expired_at
    # if expired_at の部分は、expired_at はnil 場合ってこと
    # だから次の行は、expired_at は nil じゃない、そして expired_at は released_at より古いだったら実行する
    if expired_at && expired_at < released_at
      # :expired_at_too_old は config/locales/ja.yml に入ってます。
      errors.add(:expired_at, :expired_at_too_old)
     end
  end

  def clear_expired_at
    self.expired_at = nil if @no_expiration
  end

end
