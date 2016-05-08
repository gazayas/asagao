class Entry < ActiveRecord::Base

  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  # この２つがないと、Railsはentriesテーブルにauthor_idというカラムがあり、
  # Authorという名前のモデルを参照しているのだと誤解してしまいます。

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: {maximum: 200}
  validates :body, :posted_at, presence: true
  validates :status, inclusion: {in: STATUS_VALUES}

  # ４行目ではstatusカラムにセットできる値の配列を定数STATUS_VALUES
  # として定義し、８行目でバリデーションを設定に利用しています。

  # Entryモデルにスコープを設定し、見る人に応じて閲覧できる
  # ブログ記事を絞り込めるようにします。
  scope :common, -> {where(status: "public")}
  scope :published, -> {where("status <> ?", "draft")}
  scope :full, ->(member) {
    where("status <> ? OR member_id = ?", "draft", member.id)
  }
  scope :readable_for, ->(member) {member ? full(member) : common}

  # ビューで使うメソッドを記述します
  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status]}
    end

    def sidebar_entries(member, num = 5)
      readable_for(member).order(posted_at: :desc).limit(num)
    end
  end

end
